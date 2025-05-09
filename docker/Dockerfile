FROM debian:bullseye-slim

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
  nginx \
  curlftpfs \
  openssl \
  bash \
  cron \
  && mkdir -p /run/nginx \
  && apt-get clean

# 复制 nginx 配置文件
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-default.conf /etc/nginx/conf.d/default.conf

# 拷贝配置文件和脚本
COPY entrypoint.sh /entrypoint.sh
COPY clear.sh /clear.sh

# 设置脚本权限
RUN chmod +x /entrypoint.sh /clear.sh

# 暴露端口
EXPOSE 80

# 设置入口点
ENTRYPOINT ["/entrypoint.sh"]