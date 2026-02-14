# Backup script path
BACKUP_SCRIPT=$PROXY_DIR/backup.sh

# Creates backup script
cat <<EOF | sudo tee "$BACKUP_SCRIPT"
#!/usr/bin/env bash
set -euo pipefail
DATE=\$(date +%Y-%m-%d_%H-%M-%S)

aws s3 cp "$PROXY_DIR" "s3://$BUCKET_NAME/backups/\$DATE/" --recursive \
  --exclude "velocity.jar" \
  --exclude "logs/*" \
  --exclude "plugins/*.jar" \
  --exclude "cache/*" \
  --exclude "crash-reports/*" \
  --exclude "timings/*" \
  --exclude "usercache.json" \
  --exclude "libraries/*" \
  --exclude "versions/*"
EOF

# Makes backup script executable
sudo chown "$USERNAME:$GROUPNAME" "$BACKUP_SCRIPT"
sudo chmod 750 "$BACKUP_SCRIPT"

# Creates backup service
cat <<EOF | sudo tee /etc/systemd/system/backup.service
[Unit]
Description=Backup Minecraft files
Wants=network-online.target
After=network-online.target
DefaultDependencies=no
Before=shutdown.target reboot.target halt.target

[Service]
User=$USERNAME
Group=$GROUPNAME
WorkingDirectory=$PROXY_DIR
ExecStart=$BACKUP_SCRIPT
StandardInput=null
Restart=on-failure
RestartSec=5s
Type=oneshot
RemainAfterExit=true

[Install]
WantedBy=halt.target reboot.target shutdown.target
EOF

# Creates backup timer
cat <<EOF | sudo tee /etc/systemd/system/backup.timer
[Unit]
Description=Run Minecraft Backup Service Daily
Wants=network-online.target

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Reloads systemd to apply new service and timer
sudo systemctl daemon-reload

# Starts backup service
sudo systemctl enable backup.service
sudo systemctl start backup.service

# Starts backup timer
sudo systemctl enable backup.timer
sudo systemctl start backup.timer
