#!/bin/bash
BACKUP_DIR="$HOME/projects/deploy-ghost/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_PATH="$BACKUP_DIR/ghost_backup_$DATE"
mkdir -p "$BACKUP_PATH"

docker run --rm \
  -v deploy-ghost_ghost_content:/data \
  -v "$BACKUP_PATH":/backup \
  alpine \
  tar czf /backup/ghost_content.tar.gz -C /data .

docker exec ghost-db \
  mysqldump -u ghost -pghostpass ghost > "$BACKUP_PATH/ghost_db.sql"

echo "[✓] Backup à $BACKUP_PATH"
