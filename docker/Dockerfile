FROM alpine:latest

RUN apk update && \
    apk add --no-cache \
        bash \
        coreutils \
        iputils \
        curl \
        drill \
        bind-tools \
        git \
        zsh \
        jq \
        vim \
        strace \
        tcpdump \
        htop \
        iperf \
        iproute2 \
        net-tools \
        iptables 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
