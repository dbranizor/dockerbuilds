#!/bin/sh

set x

VERSION=$(cat ./VERSION)
./build.sh

LOCAL_TAG=keycloak-${VERSION}-2
HUB_TAG=dbranizor/dsb:$LOCAL_TAG

docker tag dsb-keycloak:latest dsb-keycloak:$LOCAL_TAG
docker tag dsb-keycloak:$LOCAL_TAG $HUB_TAG
docker push $HUB_TAG

echo $HUB_TAG > dsb-keycloak
