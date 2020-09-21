ADD file:45a381049c52b5664e5e911dead277b25fadbae689c0bb35be3c42dff0f2dffe in / 
/bin/sh -c [ -z "$(apt-get indextargets)" ]
/bin/sh -c set -xe 		&& echo '#!/bin/sh' > /usr/sbin/policy-rc.d 	&& echo 'exit 101' >> /usr/sbin/policy-rc.d 	&& chmod +x /usr/sbin/policy-rc.d 		&& dpkg-divert --local --rename --add /sbin/initctl 	&& cp -a /usr/sbin/policy-rc.d /sbin/initctl 	&& sed -i 's/^exit.*/exit 0/' /sbin/initctl 		&& echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup 		&& echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean 	&& echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean 	&& echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean 		&& echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages 		&& echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes 		&& echo 'Apt::AutoRemove::SuggestsImportant "false";' > /etc/apt/apt.conf.d/docker-autoremove-suggests
/bin/sh -c mkdir -p /run/systemd && echo 'docker' > /run/systemd/container
CMD ["/bin/bash"]
LABEL maintainer=NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>
/bin/sh -c NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/7fa2af80.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA &&     echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -
#COPY file:ac92ff4b158017dfd91da460f62eb86f57f7c58aaad5335996ab3cda9d097ce5 in /etc/yum.repos.d/cuda.repo 
ENV CUDA_VERSION=10.1.243
ENV CUDA_PKG_VERSION=10-1-10.1.243-1
RUN /bin/sh -c apt-get install -y cuda-cudart-$CUDA_PKG_VERSION cuda-compat-10-1 &&     ln -s cuda-10.1 /usr/local/cuda 
/bin/sh -c echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf &&     echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV NVIDIA_REQUIRE_CUDA=cuda>=10.1 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411
LABEL maintainer=NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>
RUN /bin/sh -c apt-get install -y         cuda-libraries-$CUDA_PKG_VERSION cuda-nvtx-$CUDA_PKG_VERSION     libcublas10-10.2.1.243-1
LABEL maintainer=NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>
RUN /bin/sh -c apt-get install -y         cuda-nvml-dev-$CUDA_PKG_VERSION         cuda-command-line-tools-$CUDA_PKG_VERSION cuda-libraries-dev-$CUDA_PKG_VERSION         cuda-minimal-build-$CUDA_PKG_VERSION         libcublas-devel-10.2.1.243-1
ENV LIBRARY_PATH=/usr/local/cuda/lib64/stubs
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
RUN /bin/sh -c apt-get --disablerepo=cuda install -y epel-release &&     apt-get --disablerepo=cuda install -y libgomp libgfortran4 mysql-devel openblas-devel lapack-devel
COPY dir:b44965ae0cc6f02e2aaff6b228ba4913790040f565f085814a101bab378cbf44 in /var/lib/milvus 
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64:/var/lib/milvus/lib
WORKDIR /var/lib/milvus
CMD ["/var/lib/milvus/bin/milvus_server" "-c" "/var/lib/milvus/conf/server_config.yaml"]
EXPOSE 19530
