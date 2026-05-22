#!/bin/bash
# 数据库备份脚本

set -euo pipefail

# 配置项
COMPRESS="false"              # 是否压缩备份文件 (true/false)
BACKUP_DIR="backups"          # 备份文件存放目录
CLEAN_OLD_BACKUPS="true"      # 是否自动清理旧备份 (true/false)
RETENTION_DAYS="7"            # 保留备份天数

cd "$(dirname "$0")/.." || exit 1

# 自动探测 docker compose 命令（v2 用空格，v1 用横杠）
if docker compose version &>/dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    DOCKER_COMPOSE="docker-compose"
fi

# 获取当前时间戳
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# 从 .env 安全读取配置
MYSQL_PASSWORD=$(grep '^MYSQL_PASSWORD=' .env | cut -d'=' -f2- | xargs)
MYSQL_DATABASE=$(grep '^MYSQL_DATABASE=' .env | cut -d'=' -f2- | xargs)

if [ -z "${MYSQL_PASSWORD}" ] || [ -z "${MYSQL_DATABASE}" ]; then
    echo "❌ 错误：请在 .env 文件中配置 MYSQL_PASSWORD 和 MYSQL_DATABASE"
    exit 1
fi

mkdir -p "${BACKUP_DIR}"

if [ "${COMPRESS}" = "true" ]; then
    BACKUP_FILE="${BACKUP_DIR}/backup_${TIMESTAMP}.sql.gz"
    ${DOCKER_COMPOSE} exec -T mysql sh -c 'mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' | gzip > "${BACKUP_FILE}"
else
    BACKUP_FILE="${BACKUP_DIR}/backup_${TIMESTAMP}.sql"
    ${DOCKER_COMPOSE} exec -T mysql sh -c 'mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' > "${BACKUP_FILE}"
fi

if [ ! -s "${BACKUP_FILE}" ]; then
    echo "❌ 备份失败：mysqldump 未生成有效数据，请检查 .env 中 MYSQL_PASSWORD 是否正确"
    rm -f "${BACKUP_FILE}"
    exit 1
fi

echo "✅ 备份完成！文件: ${BACKUP_FILE} ($([ "${COMPRESS}" = "true" ] && echo '已压缩' || echo '未压缩'))"

if [ "${CLEAN_OLD_BACKUPS}" = "true" ]; then
    echo "🔄 正在清理 ${RETENTION_DAYS} 天前的旧备份..."
    find "${BACKUP_DIR}" -name "backup_*.sql*" -type f -mtime "+${RETENTION_DAYS}" -delete
    echo "✅ 清理完成"
fi