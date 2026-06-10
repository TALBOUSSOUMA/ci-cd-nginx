FROM nginx:alpine

# Copie la config personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copie le contenu web
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80