#!/bin/sh
VERSION=$(cat ./VERSION)

docker build --build-arg VERSION=$VERSION -t dsb-keycloak:latest .
