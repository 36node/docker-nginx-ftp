#!/bin/sh

set -e

# 检查所有必需的环境变量是否设置
: "${FTP_USER:?需要设置 FTP_USER}"
: "${FTP_PASSWORD:?需要设置 FTP_PASSWORD}"
: "${FTP_SERVER:?需要设置 FTP_SERVER}"

# 导出环境变量到 /etc/environment
echo "FTP_RETAIN_DAYS=$FTP_RETAIN_DAYS" >> /etc/environment

# 创建挂载目标目录
mkdir -p /mnt/ftp

# 使用 ftpfs 挂载 FTP 服务器
echo "Mounting FTP server..."
curlftpfs ftp://$FTP_USER:$FTP_PASSWORD@$FTP_SERVER$FTP_REMOTE_DIR /mnt/ftp -o allow_other

# 判断是否需要启动 crontab
if [ -n "$FTP_RETAIN_DAYS" ]; then
  echo "Starting cron as FTP_RETAIN_DAYS is set to $FTP_RETAIN_DAYS"
  # 配置 crontab 每 5 分钟执行一次
  echo "*/2 * * * * /clear.sh >> /var/log/cron.log 2>&1" | crontab -
  # 启动 cron 服务
  service cron start
else
  echo "FTP_RETAIN_DAYS is not set, skipping cron start"
fi

# 启动日志跟踪，将 cron 日志输出到 stdout
touch /var/log/cron.log
tail -f /var/log/cron.log &

# 启动 nginx 服务
echo "Starting nginx"
nginx -g 'daemon off;'