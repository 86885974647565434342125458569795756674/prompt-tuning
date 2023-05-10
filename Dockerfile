ARG FROM_IMAGE_NAME=489298/tensorflow:22.08-tf2-py3
FROM ${FROM_IMAGE_NAME}

# Install the latest jax
RUN pip install jax[cuda]==0.4.1 -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

# setup directory paths
#如该目录不存在，WORKDIR 会帮你建立目录
WORKDIR /opt/prompt-tuning

# 安装python模块
# get all pile dependencies.
COPY prompt-tuning .
RUN pip install -e . && pip install -r pile_requirements.txt && pip install t5
