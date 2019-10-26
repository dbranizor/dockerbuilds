#!/bin/bash

docker tag dsb-minio:v1 dsb-minio:latest
docker tag dsb-minio:v1 dbranizor/dsb:minio
docker push dbranizor/dsb:minio
