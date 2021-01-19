# Hướng dẫn cài đặt tất cả các app lên docker bằng lệnh docker-compose:

## Cài đặt Docker
### Bước 1: Chạy lệnh update
```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```
### Bước 2: Thêm repo của docker vào Ubuntu
```
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```


- [x] Đã test
- [ ] Chưa Test
### Bước 3: Cài đặt Docker và những thứ liên quan
```
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
### Test xem Docker đã chạy chưa
```
sudo docker -v
```
## Cài đặt Docker Compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
### Test xem Docker Compose đã chạy chưa
```
sudo docker-compose --version
```

## List những app hiện đang có trong file:
- [x] Gitlab:                     port **9000**
- [x] Jenkins:                    port **8081**
- [x] SonarQube:                  port **9090**
- [x] Docker Registry:            port **5000**
- [x] Nexus Repository Manager:   port **10680**
- [ ] Postgres DB (được cài chung với Sonarqube, chưa rõ là có cần thiết hay không)

## Những lỗi thường gặp:
- Không tìm thấy đường dẫn đến $GITLAB_HOME:
  - chạy lệnh `export GITLAB_HOME=/srv/gitlab` để thêm biến môi trường, tạo đường dẫn đến những folder được khai báo trong file `docker-compose.yml`
```
...
volumes:
      - '$GITLAB_HOME/config:/etc/gitlab'
      - '$GITLAB_HOME/logs:/var/log/gitlab'
      - '$GITLAB_HOME/data:/var/opt/gitlab'
```
      
- Nexus thông báo lỗi permission:
  - Chạy lệnh `sudo chmod 777 /srv/nexus` cho folder chứa dữ liệu của nexus đã được khai báo trong file ```docker-compose.yml```
```
  nexus:
    image: 'sonatype/nexus3'
    restart: always
    container_name: nexus
    ports:
      - '10680:8081'
    volumes:
      - '/srv/nexus:/nexus-data'
```

- Lỗi Elasticsearch: Max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
  - Chạy lệnh  `sysctl -w vm.max_map_count=262144`
  Lưu ý: cần phải chạy lại khi reboot máy.
  - Hoặc có thể thêm dòng `vm.max_map_count = 262144` vào file /etc/sysctl.conf
