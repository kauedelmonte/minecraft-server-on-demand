# Create plugins directory
sudo -u "$USERNAME" mkdir -p "$PROXY_DIR/plugins"

# Download plugins
sudo -u "$USERNAME" wget -O "$PROXY_DIR/plugins/Geyser.jar" https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/velocity
sudo -u "$USERNAME" wget -O "$PROXY_DIR/plugins/Floodgate.jar" https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/velocity
sudo -u "$USERNAME" wget -O "$PROXY_DIR/plugins/ViaVersion.jar" https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.7.0/VELOCITY/ViaVersion-5.7.0.jar

# Start proxy to generate config files
sudo -u "$USERNAME" /usr/bin/screen -dmS minecraft-proxy /usr/bin/java -Xms"$PROXY_MEMORY" -Xmx"$PROXY_MEMORY" -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:MaxInlineLevel=15 -jar "$PROXY_DIR/velocity.jar"

# Wait until the proxy is fully started
sleep 20

# Stop the proxy
sudo -u "$USERNAME" /usr/bin/screen -S minecraft-proxy -X quit || true

# Geyser Config
GEYSER_CONFIG="$PROXY_DIR/plugins/Geyser-Velocity/config.yml"
if [ -f "$GEYSER_CONFIG" ]; then
  sudo -u "$USERNAME" sed -i 's/auth-type: online/auth-type: floodgate/' "$GEYSER_CONFIG"
fi
