#cloud-config
repo_update: true
repo_upgrade: all

write_files:
  - content: |
      server {
        listen 80;

        location / {
            proxy_pass http://localhost:8000;
            proxy_redirect     off;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host $server_name;
        }
        
        location /health {
            access_log off;
            return 200 'OK!';
            add_header Content-Type text/plain;
        }
      }
    path: /tmp/nginx.conf
runcmd:
 - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
 - apt-get update
 - apt-get -y install libffi-dev libmariadb3 libmariadb-dev
 - git clone ${app_source} /app
 - mv /tmp/docker-compose.yml /tmp/nginx.conf /app
 - su -l ubuntu -c "cd /app/src && gunicorn --bind 0.0.0.0:8000 app:app"
