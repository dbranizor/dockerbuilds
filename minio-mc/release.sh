#!/bin/bash

docker tag dsb-minio-mc:v1 dsb-minio-mc:latest
docker tag dsb-minio-mc:v1 dbranizor/dsb:minio-mc
docker push dbranizor/dsb:minio-mc
