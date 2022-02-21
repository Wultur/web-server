server {

    root /var/www/nginx.ddnsking.com;
    index index.html index.htm;

    server_name nginx.ddnsking.com;
    location / {
        try_files $uri $uri/ /index.php;
    }

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/nginx.ddnsking.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nginx.ddnsking.com/privkey.pem;
    ssl_trusted_certificate /etc/letsencrypt/live/nginx.ddnsking.com/chain.pem;

}

server {
    if ($host = nginx.ddnsking.com) {
        return 301 https://$host$request_uri;
    }

    listen 80;

    server_name nginx.ddnsking.com;
    return 404;
}