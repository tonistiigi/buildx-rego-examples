
ARG BUILDKIT_VERSION=v0.26.1

FROM scratch
ARG BUILDKIT_VERSION
ADD https://github.com/moby/buildkit.git#${BUILDKIT_VERSION} /