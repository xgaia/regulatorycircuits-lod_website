FROM alpine:3.9 AS builder
MAINTAINER "Xavier Garnier <xavier.garnier@irisa.fr>"

ENV MODE prod
COPY . /website
WORKDIR /website

RUN apk add --update --no-cache bash make python3 python3-dev libxslt-dev musl-dev gcc jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev harfbuzz-dev fribidi-dev && \
    make install clean build

# Final image
FROM nginx:1.18.0-alpine
COPY --from=builder /website/output /usr/share/nginx/html
