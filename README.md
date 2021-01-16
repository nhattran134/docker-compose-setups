# Hướng dẫn cài đặt tất cả các app lên docker bằng lệnh docker-compose:


- [x] Đã test
- [ ] Chưa Test


## List những app hiện đang có trong file:
- [x] Gitlab:**9000**
- [x] Jenkins:**8081**
- [x] SonarQube:**9090**
- [x] Docker Registry:**5000**
- [x] Nexus Repository Manager:**10680**
- [ ] Postgres DB

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
