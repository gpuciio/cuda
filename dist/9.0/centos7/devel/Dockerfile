ARG IMAGE_NAME
FROM ${IMAGE_NAME}:9.0-runtime-centos7 as base

FROM base as base-amd64

ENV NV_CUDA_LIB_VERSION 9.0.176-1
ENV NV_NVPROF_VERSION 9.0.176-1
ENV NV_CUDA_CUDART_DEV_VERSION 9.0.176-1
ENV NV_NVML_DEV_VERSION 9.0.176-1

ENV NV_LIBNPP_DEV_VERSION 9.0.176-1

ENV NV_LIBCUBLAS_DEV_PACKAGE_NAME cuda-cublas-dev-9-0
ENV NV_LIBCUBLAS_DEV_VERSION 9.0.176-1
ENV NV_LIBCUBLAS_DEV_PACKAGE ${NV_LIBCUBLAS_DEV_PACKAGE_NAME}-${NV_LIBCUBLAS_DEV_VERSION}


FROM base as base-ppc64le

ENV NV_CUDA_LIB_VERSION 9.0.176-1
ENV NV_NVPROF_VERSION 9.0.176-1
ENV NV_CUDA_CUDART_DEV_VERSION 9.0.176-1
ENV NV_NVML_DEV_VERSION 9.0.176-1

ENV NV_LIBNPP_DEV_VERSION 9.0.176-1

ENV NV_LIBCUBLAS_DEV_PACKAGE_NAME cuda-cublas-dev-9-0
ENV NV_LIBCUBLAS_DEV_VERSION 9.0.176-1
ENV NV_LIBCUBLAS_DEV_PACKAGE ${NV_LIBCUBLAS_DEV_PACKAGE_NAME}-${NV_LIBCUBLAS_DEV_VERSION}


LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"


RUN yum install -y \
    make \
    cuda-nvml-dev-9-0-${NV_NVML_DEV_VERSION} \
    cuda-command-line-tools-9-0-${NV_CUDA_LIB_VERSION} \
    cuda-cudart-dev-9-0-${NV_CUDA_CUDART_DEV_VERSION} \
    cuda-libraries-dev-9-0-${NV_CUDA_LIB_VERSION} \
    cuda-minimal-build-9-0-${NV_CUDA_LIB_VERSION} \
    cuda-nvprof-9-0-${NV_NVPROF_VERSION} \
    cuda-npp-dev-9-0-${NV_LIBNPP_DEV_VERSION} \
    ${NV_LIBCUBLAS_DEV_PACKAGE} \
    && yum clean all \
    && rm -rf /var/cache/yum/*

