FROM nginx
COPY dist /usr/share/nginx/html
COPY nginx-config.conf /etc/nginx/nginx.conf
COPY nginx.crt /etc/nginx
COPY nginx.key /etc/nginx
EXPOSE 80 443