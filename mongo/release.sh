#!/bin/bash
set x

./build.sh
LOCAL_TAG=mongo-4.0.10v2
HUB_TAG=dbranizor/dsb:$LOCAL_TAG

docker tag dsb-mongo:latest dsb-mongo:$LOCAL_TAG
docker tag dsb-mongo:$LOCAL_TAG $HUB_TAG
docker push $HUB_TAG

echo $HUB_TAG > mongo
mc cp mongo local/build-tags

