FROM --platform=$BUILDPLATFORM tinygo/tinygo:0.26.0 AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
ARG TARGETOS TARGETARCH
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /out/netcatty .

FROM alpine
COPY --from=build /out/netcatty /bin
