# Creates server folder
sudo chown -R "$USERNAME:$GROUPNAME" "$PROXY_DIR/"
sudo chmod -R 750 "$PROXY_DIR/"
sudo setfacl -R -m "u:$USERNAME:rwx" -m "g:$GROUPNAME:rwx" "$PROXY_DIR"
sudo setfacl -d -R -m "u:$USERNAME:rwx" -m "g:$GROUPNAME:rwx" "$PROXY_DIR"

# Download proxy jar
sudo -u "$USERNAME" wget -O "$PROXY_DIR/velocity.jar" https://fill-data.papermc.io/v1/objects/ccc49f71751ece26568d3476392d6130c8b43f2e5f3a88313325b9278a52babd/velocity-3.4.0-SNAPSHOT-559.jar