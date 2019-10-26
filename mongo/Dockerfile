
from mongo:4.0.10

# Set one or more individual labels
LABEL dsb.mongo.version="0.0.1-beta"
LABEL vendor="DSB Mongo"
LABEL dsb.mongo.release-date="2015-02-12"
LABEL dsb.mongo.version.is-production=""
# Environment labels
ENV MONGO_USER=unkown
ENV MONGO_PASSWORD=unkown
ENV MONGO_DATABASE=unkown

# Copy entrypoint script
# COPY init/init_dbusers.js /docker-entrypoint-initdb.d/
COPY init/dsb_docker_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/dsb_docker_entrypoint.sh

RUN mkdir /home/mongodb

ENTRYPOINT ["dsb_docker_entrypoint.sh"]