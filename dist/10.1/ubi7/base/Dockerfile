FROM registry.access.redhat.com/ubi7/ubi:latest as base

FROM base as base-amd64

ENV NVARCH x86_64
ENV NVIDIA_REQUIRE_CUDA cuda>=10.1 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411 brand=tesla,driver>=418,driver<419
ENV NV_CUDA_CUDART_VERSION 10.1.243-1

COPY cuda.repo-x86_64 /etc/yum.repos.d/cuda.repo
COPY nvidia-ml.repo-x86_64 /etc/yum.repos.d/nvidia-ml.repo


FROM base as base-ppc64le

ENV NVARCH ppc64le
ENV NVIDIA_REQUIRE_CUDA cuda>=10.1
ENV NV_CUDA_CUDART_VERSION 10.1.243-1

COPY cuda.repo-ppc64le /etc/yum.repos.d/cuda.repo
COPY nvidia-ml.repo-ppc64le /etc/yum.repos.d/nvidia-ml.repo

FROM base-${TARGETARCH}

ARG TARGETARCH

LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel7/${NVARCH}/7fa2af80.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA && \
    echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict  -

ENV CUDA_VERSION 10.1

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN yum upgrade -y && yum install -y \
    cuda-cudart-10-1-${NV_CUDA_CUDART_VERSION} \
    cuda-compat-10-1 \
    && ln -s cuda-10.1 /usr/local/cuda \
    && yum clean all \
    && rm -rf /var/cache/yum/*

# nvidia-docker 1.0
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

COPY NGC-DL-CONTAINER-LICENSE /

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility