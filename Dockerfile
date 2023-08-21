FROM lsiobase/alpine:3.16 as builder

RUN apk add --no-cache curl unzip \
&& ARIANG_VER=$(wget -qO- https://api.github.com/repos/mayswind/AriaNg/tags | grep 'name' | cut -d\" -f4 | head -1 ) \
&& wget -P /tmp https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VER}/AriaNg-${ARIANG_VER}-AllInOne.zip \
&& unzip /tmp/AriaNg-${ARIANG_VER}-AllInOne.zip -d /tmp

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
