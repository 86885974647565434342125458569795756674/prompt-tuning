ARG FROM_IMAGE_NAME=489298/tensorflow:22.08-tf2-py3
FROM ${FROM_IMAGE_NAME}

# Install the latest jax
RUN pip install jax[cuda]==0.4.1 -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

#WORKDIR /opt/gnutls-bin

#RUN apt-get update -y && apt-get install gnutls-bin -y && git config --global http.sslVerify false && git config --global http.postBuffer 1048576000

#RUN echo "deb-src http://archive.ubuntu.com/ubuntu trusty main restricted #Added by software-properties" >> /etc/apt/sources.list && echo "deb-src http://gb.archive.ubuntu.com/ubuntu/ trusty restricted main universe multiverse #Added by software-properties" >> /etc/apt/sources.list && echo "deb-src http://gb.archive.ubuntu.com/ubuntu/ trusty-updates restricted main universe multiverse #Added by software-properties" >> /etc/apt/sources.list && echo "deb-src http://gb.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse #Added by software-properties" >> /etc/apt/sources.list && echo "deb-src http://security.ubuntu.com/ubuntu trusty-security restricted main universe multiverse #Added by software-properties" >> /etc/apt/sources.list && echo "deb-src http://gb.archive.ubuntu.com/ubuntu/ trusty-proposed restricted main universe multiverse #Added by software-properties" >> /etc/apt/sources.list 

#WORKDIR /opt

#RUN cp /etc/apt/sources.list /etc/apt/sources.list~ && sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && apt-get update && apt-get install build-essential fakeroot dpkg-dev -y && apt-get build-dep git -y && apt-get install libcurl4-openssl-dev -y 

#WORKDIR /opt/source-git

#RUN apt-get source git 

#WORKDIR /opt/source-git/git-2.25.1

#RUN sed -i -- 's/libcurl4-gnutls-dev/libcurl4-openssl-dev/' /opt/source-git/git-2.25.1/debian/control && sed -i -- '/TEST\s*=\s*test/d' /opt/source-git/git-2.25.1/debian/rules && dpkg-buildpackage -rfakeroot -b -uc -us && dpkg -i /opt/source-git/git_*ubuntu*.deb

# setup directory paths
#如该目录不存在，WORKDIR 会帮你建立目录

WORKDIR /opt/prompt-tuning

# 安装python模块
# get all pile dependencies.
COPY prompt-tuning .
#RUN  python -m pip install --upgrade pip && pip install -e . 

RUN pip install -e . && pip install -r pile_requirements.txt && pip install t5
