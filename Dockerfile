FROM debian as builder
# ARIANG_VER
ARG ARIANG_VER=1.1.6
# download AriaNg AllInOne
RUN apt-get -y update \
&& apt-get -y install build-essential make curl wget unzip git \
&& wget -P /tmp https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VER}/AriaNg-${ARIANG_VER}-AllInOne.zip \
&& unzip /tmp/AriaNg-${ARIANG_VER}-AllInOne.zip -d /tmp \
&& cd /tmp \
&& git clone https://github.com/iori-yja/tiny-docker-httpd.git \
&& cd /tmp/tiny-docker-httpd \
&& make

# install AriaNg
FROM scratch
# set label
LABEL maintainer="NG6"
# copy AriaNg
COPY --from=builder /tmp/tiny-docker-httpd/darkhttpd /darkhttpd
COPY --from=builder /tmp/index.html /www/index.html
# darkhttpd port
EXPOSE 80
# start darkhttpd
ENTRYPOINT [ "/darkhttpd" ]
CMD [ "/www" ]