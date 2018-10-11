FROM nginx
MAINTAINER odadph@gmail.com

# Change index.html
ADD index.html /usr/share/nginx/html/

# Port
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
