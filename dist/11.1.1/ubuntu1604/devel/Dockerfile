ARG IMAGE_NAME
FROM ${IMAGE_NAME}:11.1.1-runtime-ubuntu16.04 as base

ENV NV_CUDA_LIB_VERSION "11.1.1-1"

FROM base as base-amd64

ENV NV_CUDA_CUDART_DEV_VERSION 11.1.74-1
ENV NV_NVML_DEV_VERSION 11.1.74-1
ENV NV_LIBCUSPARSE_DEV_VERSION 11.3.0.10-1
ENV NV_LIBNPP_DEV_VERSION 11.1.2.301-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-dev-11-1=${NV_LIBNPP_DEV_VERSION}

ENV NV_LIBCUBLAS_DEV_VERSION 11.3.0.106-1
ENV NV_LIBCUBLAS_DEV_PACKAGE_NAME libcublas-dev-11-1
ENV NV_LIBCUBLAS_DEV_PACKAGE ${NV_LIBCUBLAS_DEV_PACKAGE_NAME}=${NV_LIBCUBLAS_DEV_VERSION}

ENV NV_LIBNCCL_DEV_PACKAGE_NAME libnccl-dev
ENV NV_LIBNCCL_DEV_PACKAGE_VERSION 2.7.8-1
ENV NCCL_VERSION 2.7.8-1
ENV NV_LIBNCCL_DEV_PACKAGE ${NV_LIBNCCL_DEV_PACKAGE_NAME}=${NV_LIBNCCL_DEV_PACKAGE_VERSION}+cuda11.1

FROM base-${TARGETARCH}

ARG TARGETARCH

LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-dev-11-1=${NV_CUDA_CUDART_DEV_VERSION} \
    cuda-command-line-tools-11-1=${NV_CUDA_LIB_VERSION} \
    cuda-minimal-build-11-1=${NV_CUDA_LIB_VERSION} \
    cuda-libraries-dev-11-1=${NV_CUDA_LIB_VERSION} \
    cuda-nvml-dev-11-1=${NV_NVML_DEV_VERSION} \
    ${NV_LIBNPP_DEV_PACKAGE} \
    libcusparse-dev-11-1=${NV_LIBCUSPARSE_DEV_VERSION} \
    ${NV_LIBCUBLAS_DEV_PACKAGE} \
    ${NV_LIBNCCL_DEV_PACKAGE} \
    && rm -rf /var/lib/apt/lists/*

# Keep apt from auto upgrading the cublas and nccl packages. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
RUN apt-mark hold ${NV_LIBCUBLAS_DEV_PACKAGE_NAME} ${NV_LIBNCCL_DEV_PACKAGE_NAME}

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs