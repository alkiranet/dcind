#!/bin/bash

# must be an alpine linux image
BASE_IMAGES=("golang:1.14-alpine" "golang:1.16-alpine" "node:14.15.4-alpine3.12")

for base_image in ${BASE_IMAGES[*]}; do
    # Extract version from base image
    splitted_base_image=(${base_image//:/ })
    image_repo=${splitted_base_image[0]}
    version=${splitted_base_image[1]}

    # Extract repository and image name
    splitted_image_repo=(${image_repo//\// })
    image_name=${splitted_image_repo[${#splitted_image_repo[@]}-1]}

    echo "building dcind image for base image ${base_image}"
    docker build . -t dcind-${image_name}:${version} --build-arg BASE_IMAGE=${base_image}
    if [ $? -ne 0 ]; then
        echo "failed to  build dcind image for base image ${base_image}"
        exit 1
    fi
    echo "dcind image for base image ${base_image} built successfully"
done