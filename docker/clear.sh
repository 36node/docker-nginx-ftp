#!/bin/sh

# 加载环境变量
. /etc/environment

# 打印开始清理的日志
echo "Starting cleanup of files older than $FTP_RETAIN_DAYS days."

# 删除早于 FTP_RETAIN_DAYS 天的文件
n=$((FTP_RETAIN_DAYS+1))
dt=$(date -d "$n days ago 23:59:59" +"%Y-%m-%d %H:%M:%S")
find /mnt/ftp -type f ! -newermt "$dt" -delete

# 打印清理完成的日志
echo "Cleanup completed."
