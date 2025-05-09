#!/bin/sh

# 加载环境变量
. /etc/environment

# 打印开始清理的日志
echo "Starting cleanup of files older than $FTP_RETAIN_DAYS days."

# 删除早于 FTP_RETAIN_DAYS 天的文件
find /mnt/ftp -type f -mtime +$FTP_RETAIN_DAYS -delete

# 打印清理完成的日志
echo "Cleanup completed."