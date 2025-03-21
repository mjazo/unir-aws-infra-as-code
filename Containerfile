FROM nginx:latest

# Copiar el archivo HTML a la carpeta de NGINX
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
