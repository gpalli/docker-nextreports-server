FROM tomcat:latest
MAINTAINER Guillermo Palli <guillermo.palli@gmail.com>

RUN mkdir /reports

RUN cd /usr/local/tomcat/webapps \
    && curl -SL http://www.asf.ro/next_reports_releases/server/nextreports-server.war > nextreports-server.war

ADD reports.xml /usr/local/tomcat/conf/Catalina/localhost/reports.xml

RUN sed -i 's|common.loader=|common.loader="${catalina.base}/reports",|g' \
            /usr/local/tomcat/conf/catalina.properties
