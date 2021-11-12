#!/bin/bash
set -e

#
# This script requires buildkit: https://docs.docker.com/buildx/working-with-buildx/
#

OSES=(
  "centos7"
  "centos8"
  "ubuntu18.04"
  "ubuntu20.04"
)

IMAGE_NAME="gpuci/cuda"
CUDA_VERSION="11.5.0"

BUILDER_NAME="cuda"
docker buildx create --use ${PLATFORM_ARG} --driver-opt image=moby/buildkit:v0.8.1 --name cuda
docker buildx use "$BUILDER_NAME"
docker buildx inspect --bootstrap
trap "docker buildx rm $BUILDER_NAME" EXIT

for OS in "${OSES[@]}"; do
  ARCHES="x86_64, arm64"
  # ARCHES="x86_64"
  if [ "$OS" = "centos7" ]; then
    echo "building CentOS 7!"
    ARCHES="x86_64"
  fi

  PLATFORM_ARG=`printf '%s ' '--platform'; for var in $(echo $ARCHES | sed "s/,/ /g"); do printf 'linux/%s,' "$var"; done | sed 's/,*$//g'`

  cp NGC-DL-CONTAINER-LICENSE "dist/${CUDA_VERSION}/${OS//.}/base/"
  cp nccl*.txz "dist/${CUDA_VERSION}/${OS//.}/runtime/"
  cp nccl*.txz "dist/${CUDA_VERSION}/${OS//.}/devel/"

  docker buildx build --no-cache --push ${PLATFORM_ARG} -t "${IMAGE_NAME}:${CUDA_VERSION}-base-${OS}" "dist/${CUDA_VERSION}/${OS//.}/base"
  docker buildx build --no-cache --push ${PLATFORM_ARG} -t "${IMAGE_NAME}:${CUDA_VERSION}-runtime-${OS}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" "dist/${CUDA_VERSION}/${OS//.}/runtime"
  docker buildx build --no-cache --push ${PLATFORM_ARG} -t "${IMAGE_NAME}:${CUDA_VERSION}-devel-${OS}" --build-arg "IMAGE_NAME=${IMAGE_NAME}" "dist/${CUDA_VERSION}/${OS//.}/devel"
done
