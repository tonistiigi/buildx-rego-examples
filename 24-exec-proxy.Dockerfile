FROM debian
ADD https://download.docker.com/linux/ubuntu/dists/noble/Release /
RUN apt-get update && apt-get install -y curl
RUN curl -f http://example.com