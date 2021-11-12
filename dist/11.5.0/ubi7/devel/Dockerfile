ARG IMAGE_NAME
FROM ${IMAGE_NAME}:11.5.0-runtime-ubi7 as base

FROM base as base-amd64

ENV NV_CUDA_LIB_VERSION 11.5.0-1
ENV NV_NVPROF_VERSION 11.5.50-1
ENV NV_CUDA_CUDART_DEV_VERSION 11.5.50-1
ENV NV_NVML_DEV_VERSION 11.5.50-1
ENV NV_LIBCUBLAS_DEV_VERSION 11.7.3.1-1
ENV NV_LIBNPP_DEV_VERSION 11.5.1.53-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-devel-11-5-${NV_LIBNPP_DEV_VERSION}
ENV NV_LIBNCCL_DEV_PACKAGE_NAME libnccl-devel
ENV NV_LIBNCCL_DEV_PACKAGE_VERSION 2.11.4-1
ENV NCCL_VERSION 2.11.4
ENV NV_LIBNCCL_DEV_PACKAGE ${NV_LIBNCCL_DEV_PACKAGE_NAME}-${NV_LIBNCCL_DEV_PACKAGE_VERSION}+cuda11.5



FROM base-${TARGETARCH}

ARG TARGETARCH

LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN yum install -y \
    make \
    cuda-command-line-tools-11-5-${NV_CUDA_LIB_VERSION} \
    cuda-libraries-devel-11-5-${NV_CUDA_LIB_VERSION} \
    cuda-minimal-build-11-5-${NV_CUDA_LIB_VERSION} \
    cuda-cudart-devel-11-5-${NV_CUDA_CUDART_DEV_VERSION} \
    cuda-nvprof-11-5-${NV_NVPROF_VERSION} \
    cuda-nvml-devel-11-5-${NV_NVML_DEV_VERSION} \
    libcublas-devel-11-5-${NV_LIBCUBLAS_DEV_VERSION} \
    ${NV_LIBNPP_DEV_PACKAGE} \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ADD nccl_2.11.4-1+cuda11.5_${TARGETARCH}.txz /tmp/

RUN mv /tmp/nccl*/lib/pkgconfig/* /usr/lib64/pkgconfig/ && rm -rf /tmp/nccl*/lib/{pkgconfig,*.a} \
    && mv /tmp/nccl*/lib/* /usr/lib64/ \
    && mv /tmp/nccl*/include/* /usr/include/

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs