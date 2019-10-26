#!/bin/bash

set -x

./build.sh

LOCAL_TAG=postgres-11.4-v2
HUB_TAG="dbranizor/dsb:$LOCAL_TAG"

docker tag dsb-postgres:latest $LOCAL_TAG
docker tag $LOCAL_TAG $HUB_TAG
docker push $HUB_TAG

echo $HUB_TAG > postgres
mc cp postgres local/build-tags