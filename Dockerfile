FROM nvidia/cuda:10.1-runtime-ubuntu18.04
LABEL maintainer="manideep2510@gmail.com"
LABEL version="0.1"
LABEL description="CUDA + Milvus + Ubuntu"

RUN apt-get update
RUN apt-get install -y  
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64:/var/lib/milvus/lib
WORKDIR /var/lib/milvus
CMD ["/var/lib/milvus/bin/milvus_server" "-c" "/var/lib/milvus/conf/server_config.yaml"]
EXPOSE 19530
