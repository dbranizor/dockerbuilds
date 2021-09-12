#!/bin/bash

sleep 5

chown -R mongodb:mongodb /home/mongodb

nohup gosu mongodb mongod --dbpath=/data/db &

nohup gosu mongodb mongo admin --eval "help" > /dev/null 2>&1
RET=$?

while [[ "$RET" -ne 0 ]]; do
  echo "Waiting for MongoDB to start..."
  mongo admin --eval "help" > /dev/null 2>&1
  RET=$?
  sleep 2
done


if [ "$MONGO_USER" ] && [ "$MONGO_PASSWORD" ]; then
    # create root user
    nohup gosu mongodb mongo $MONGO_INITDB_DATABASE --eval "db.createUser({user: 'admin', pwd: '$MONGO_INITDB_ROOT_PASSWORD', roles:[{ role: 'root', db:  'admin' }, { role: 'read', db: 'local' }]});"

    # create app user/database
    nohup gosu mongodb mongo $MONGO_INITDB_DATABASE --eval "db.createUser({ user: '$MONGO_USER', pwd: '$MONGO_PASSWORD', roles: [{ role: 'readWrite', db: 'eich' }, { role: 'read', db: 'local' }]});"

fi

echo "************************************************************"
echo "Shutting down"
echo "************************************************************"
nohup gosu mongodb mongo admin --eval "db.shutdownServer();"

gosu mongodb mongod --dbpath=/data/db  --bind_ip_all
