FROM --platform=$BUILDPLATFORM golang:1.19.3-alpine AS build
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
ARG TARGETOS TARGETARCH
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -ldflags="-s -w" -o /out/netcatty .

FROM --platform=$TARGETPLATFORM zjx20/upx:latest AS upx
FROM --platform=$TARGETPLATFORM alpine:latest AS compress
COPY --from=upx /bin/upx /bin/upx
COPY --from=build /out/netcatty /out/netcatty
RUN /bin/upx --best --lzma /out/netcatty

FROM alpine
COPY --from=compress /out/netcatty /bin
