FROM --platform=$TARGETPLATFORM zjx20/upx:latest AS upx
FROM --platform=$BUILDPLATFORM golang:1.19.3-alpine AS build
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
ARG TARGETOS TARGETARCH
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -ldflags="-s -w" -o /out/netcatty .

COPY --from=upx /bin/upx /bin/upx
RUN /bin/upx --best --lzma /out/netcatty

FROM alpine
COPY --from=build /out/netcatty /bin
