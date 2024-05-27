APP=echo-server
REGISTRY=gaupt
VERSION=1.0.0
#VERSION=v1.0.6-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64 #arm64 



image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

linux_image:
	docker buildx build --platform linux/amd64 -f Dockerfile -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} .

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
