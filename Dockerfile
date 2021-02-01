FROM debian:buster

ENV ROOTER_VER=19076

RUN apt-get update &&\
    apt-get install -y bash build-essential curl flex g++ gawk gettext git-core libelf-dev libncurses5 libncurses5-dev libssl-dev libz-dev make ncurses-dev patch perl python python-distutils-extra python3 python3-dev python3-distutils-extra python3.5 rsync subversion sudo time unzip vim wget xz-utils zip zlib1g-dev && \
    apt-get clean && \
    useradd -m user && \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user

# set dummy git config
RUN git config --global user.name "user" && git config --global user.email "user@example.com"

# Copy rooter into the image and unzip it. 
COPY Rooter${ROOTER_VER}.zip /home/user/Rooter${ROOTER_VER}.zip
RUN unzip /home/user/Rooter${ROOTER_VER}.zip -d /home/user && \
    rm /home/user/Rooter${ROOTER_VER}.zip && \
    cd /home/user && \
    ./build${ROOTER_VER} && \
    rm /home/user/rooter${ROOTER_VER}-master.tar.gz && \
    rm /home/user/rooter${ROOTER_VER}/rooter${ROOTER_VER}-master.tar.gz  && \
    rm /home/user/build${ROOTER_VER}
COPY build-my-images.sh /home/user/rooter${ROOTER_VER}/build-my-images.sh    
