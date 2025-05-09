# docker-nginx-ftp

A docker image for nginx, while mounting ftp as a local folder

- auto mount ftp to local folder
- could cleanup old files, optionally
- expose with nginx

## Envrionment

- FTP_SERVER: server ip
- FTP_USER: username 
- FTP_PASSWORD: password
- FTP_REMOTE_DIR: ftp remove directory
- FTP_MOUNT_POINT: mount folder in container
- FTP_RETAIN_DAYS: The file retention days are optional. If set, it will regularly clean up the files in ftp.

## docker-compose 

```yaml
services:
  nginx:
    build:
      context: ./docker
      dockerfile: Dockerfile
    privileged: true
    ports:
      - "8080:80"
    environment:
      - FTP_USER=36node
      - FTP_PASSWORD=123456
      - FTP_SERVER=192.168.5.112
      # - FTP_REMOTE_DIR=/ht  路径必须以 / 开头
      - FTP_RETAIN_DAYS=7

  ftp:
    image: dotkevinwong/vsftpd-arm
    # image: fauria/vsftpd ## for x86
    environment:
      - FTP_USER=36node
      - FTP_PASS=123456
      - PASV_MIN_PORT=21100
      - PASV_MAX_PORT=21110
      - PASV_ADDRESS=192.168.5.112
      - LOG_STDOUT=YES
    ports:
      - '20:20/tcp'
      - '21:21/tcp'
      - '21100-21110:21100-21110/tcp'
    volumes:
      - '/tmp/ftp:/home/vsftpd'
```
