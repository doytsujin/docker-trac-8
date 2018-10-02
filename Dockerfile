FROM python:2-alpine
LABEL maintainer='tech_chihuahua@tuta.io'

RUN mkdir -p /etc/opt/trac && \
    apk update && \
    apk --no-cache --update add sqlite py-pysqlite apache2-utils && \
    pip install \
    	pytz \
	trac \
	trac-LighterTheme \
	TracMasterTickets \
	TracNav \
	TracPrivateTickets \
	TracPygments \
	TracSimpleTicket \
	TracSpamFilter \
	TracStats \
	TracTags \
	TracThemeEngine \
	TracTicketGraph

COPY conf/users.htpasswd /etc/opt/trac/users.htpasswd
COPY entrypoint.sh /usr/local/bin/trac-entrypoint.sh
RUN chmod +x /usr/local/bin/trac-entrypoint.sh

EXPOSE 80

VOLUME ["/srv/trac"]

ENTRYPOINT ["/usr/local/bin/trac-entrypoint.sh"]
CMD ["-s", "--basic-auth=project,/etc/opt/trac/users.htpasswd,trac", "/srv/trac/project"]
