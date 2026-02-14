# Creates minecraft service
cat <<EOF | sudo tee /etc/systemd/system/minecraft-proxy.service
[Unit]
Description=Minecraft Velocity Proxy
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=$USERNAME
Group=$GROUPNAME
WorkingDirectory=$PROXY_DIR

ExecStartPre=/usr/bin/test -f $PROXY_DIR/velocity.jar
ExecStart=/usr/bin/java \
        -Xms$PROXY_MEMORY -Xmx$PROXY_MEMORY \
        -XX:+UseG1GC -XX:G1HeapRegionSize=4M \
        -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled \
        -XX:MaxInlineLevel=15 \
        -jar velocity.jar

Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

# Starts minecraft service
sudo systemctl daemon-reload
sudo systemctl enable minecraft-proxy.service