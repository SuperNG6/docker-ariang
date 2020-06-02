FROM alpine:3.11 as builder
# ARIANG_VER
ARG ARIANG_VER=1.1.6
# download AriaNg AllInOne
RUN apk add --no-cache unzip \
&& wget -P /tmp https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VER}/AriaNg-${ARIANG_VER}-AllInOne.zip \
&& unzip /tmp/AriaNg-${ARIANG_VER}-AllInOne.zip -d /tmp

# install AriaNg
FROM alpine:3.11
# set label
LABEL maintainer="NG6"
# copy AriaNg
COPY --from=builder /tmp/index.html /www/index.html
# install darkhttpd
RUN apk add --no-cache darkhttpd
# darkhttpd port
EXPOSE 80
# start darkhttpd
ENTRYPOINT [ "/usr/bin/darkhttpd" ]
CMD [ "/www" ]