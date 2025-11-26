
ARG GO_VERSION=1.25

FROM golang:${GO_VERSION}-alpine AS build
RUN touch foo