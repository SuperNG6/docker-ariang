FROM debian as builder
# ARIANG_VER
ARG ARIANG_VER=1.1.7
# download AriaNg AllInOne
RUN apt-get -y update \
&& apt-get -y install wget unzip \
&& wget -P /tmp https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VER}/AriaNg-${ARIANG_VER}-AllInOne.zip \
&& unzip /tmp/AriaNg-${ARIANG_VER}-AllInOne.zip -d /tmp
# install AriaNg
FROM superng6/darkhttpd
# set label
LABEL maintainer="NG6"
# copy AriaNg
COPY --from=builder /tmp/index.html /www/index.html
# darkhttpd port
EXPOSE 80
# start darkhttpd
ENTRYPOINT [ "/darkhttpd" ]
CMD [ "/www" ]
