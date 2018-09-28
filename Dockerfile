FROM nginx
MAINTAINER odadph@gmail.com
ADD index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
