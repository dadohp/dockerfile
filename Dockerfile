FROM centos
MAINTAINER odadph@gmail.com

RUN echo $'[mongodb-org-3.4] \n\
name=MongoDB Repository \n\
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/ \n\
gpgcheck=1 \n\
enabled=1 \n\
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc ' > /etc/yum.repos.d/mongodb-org-3.4.repo

RUN yum clean all && yum install -y mongodb-org-server mongodb-org-shell mongodb-org-tools
RUN mkdir -p /data/db && chown -R mongod:mongod /data/db
RUN /usr/bin/mongod -f /etc/mongod.conf && sleep 5 && mongo admin --eval "db.createUser({user:\"admin\",pwd:\"admin123\",roles:[{role:\"root\",db:\"admin\"}]}); db.shutdownServer()"
RUN echo $'security: \n\
  authorization: enabled \n ' >> /etc/mongod.conf
RUN sed -i 's/^  bindIp: 127\.0\.0\.1/  bindIp: 0\.0\.0\.0/' /etc/mongod.conf
RUN sed -i 's/^  fork: true/  fork: false/' /etc/mongod.conf
RUN chown mongod:mongod /etc/mongod.conf
RUN cat /etc/mongod.conf

EXPOSE 27017
ENTRYPOINT /usr/bin/mongod -f /etc/mongod.conf
