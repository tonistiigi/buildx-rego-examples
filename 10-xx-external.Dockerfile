
ARG XX_VERSION=1.8.0

FROM --platform=$BUILDPLATFORM tonistiigi/xx:${XX_VERSION} AS xx

FROM alpine
COPY --from=xx / /
RUN touch foo