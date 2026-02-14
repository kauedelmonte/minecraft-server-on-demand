# Creates server user
if ! getent group "$GROUPNAME" >/dev/null; then
  sudo groupadd --system "$GROUPNAME"
fi

if ! id -u "$USERNAME" >/dev/null 2>&1; then
  sudo useradd --system --gid "$GROUPNAME" --home "$PROXY_DIR" --shell /sbin/nologin "$USERNAME"
fi

sudo usermod -aG "$GROUPNAME" "$USERNAME"
sudo install -d -m 750 -o "$USERNAME" -g "$GROUPNAME" "$PROXY_DIR"

# # Setup sudoers for managing the minecraft service
# echo "$USERNAME ALL=(ALL) NOPASSWD: /bin/systemctl start minecraft-proxy.service, /bin/systemctl stop minecraft-proxy.service, /bin/systemctl restart minecraft-proxy.service" | sudo tee /etc/sudoers.d/minecraft-proxy-service
# sudo chmod 440 /etc/sudoers.d/minecraft-proxy-service
