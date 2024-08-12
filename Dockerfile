FROM alpine:latest

RUN apk update && apk add --no-cache bash coreutils iputils curl drill bind-tools git zsh jq vim strace tcpdump htop

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
