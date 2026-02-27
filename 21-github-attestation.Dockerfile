FROM scratch
ARG CLI_VERSION=2.87.3
ARG TARGETOS TARGETARCH
ADD https://github.com/cli/cli/releases/download/v${CLI_VERSION}/gh_${CLI_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz /