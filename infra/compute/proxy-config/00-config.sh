#!/usr/bin/env bash
set -euo pipefail

# Minecraft Proxy OS user
USERNAME=${ec2_user:-minecraft-proxy}
GROUPNAME=${ec2_groupname:-minecraft-admin}

# Minecraft Proxy settings
PROXY_MEMORY=${proxy_memory:-320M}
PROXY_DIR=${proxy_dir:-/opt/minecraft-proxy}

# Minecraft Proxy Bucket for backup and restore
BUCKET_NAME=${bucket_name:-minecraft-backup}

# Minecraft Proxy Domain Name
DOMAIN_NAME=${proxy_domain_name:-minecraft.delmonte.dev}
