### Nginx & Index

FROM nginx
MAINTAINER odadph@gmail.com

# Change index.html
ADD index.html /usr/share/nginx/html/

# Port
EXPOSE 80

# Command
CMD ["nginx", "-g", "daemon off;"]
