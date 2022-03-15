FROM nginx:latest

RUN rm -f /etc/nginx/conf.d/*

ADD ./webserver/nginx.conf /etc/nginx/conf.d/appserver.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
