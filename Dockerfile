#
#
#
FROM appsoa/docker-alpine-base

ARG IMAGE_BUILD_DATE
ARG IMAGE_VERSION
LABEL build="Image-Version:- ${IMAGE_VERSION} Image-Build-Date: ${IMAGE_BUILD_DATE}"

RUN apk --update --no-cache add \
        xrdp xvfb xauth \
        alpine-desktop xfce4 ttf-freefont \
        thunar-volman faenza-icon-theme slim \ 
        xf86-input-synaptics xf86-input-mouse xf86-input-keyboard \
        setxkbmap supervisor

COPY src /

RUN xrdp-keygen xrdp auto
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

EXPOSE 3389 22
#WORKDIR /home/alpine
#USER alpine
# ENTRYPOINT ["docker-entrypoint.sh"]
# CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]