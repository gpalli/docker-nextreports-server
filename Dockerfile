FROM tomcat:latest
MAINTAINER Guillermo Palli <guillermo.palli@gmail.com>
ENV NEXTREPORTS_RELEASE=9.1

# Remove default apps and docs from tomcat
#
RUN rm -fR /usr/local/tomcat/webapps/*

# Installing NextReports war
#
RUN cd /usr/local/tomcat/webapps \
    && curl -SL https://github.com/nextreports/nextreports-server/releases/download/release-$NEXTREPORTS_RELEASE/nextreports-server.war > nextreports-server.war

# Adding Oracle JDBC
#
ADD ojdbc6-11.2.0.4.jar /usr/local/tomcat/lib/ojdbc6-11.2.0.4.jar
ADD ucp.jar /usr/local/tomcat/lib/ucp.jar

# Configure Reports and Home redirect
#
RUN mkdir /reports
ADD reports.xml /usr/local/tomcat/conf/Catalina/localhost/reports.xml
ADD index.html /usr/local/tomcat/webapps/ROOT/index.html
RUN sed -i 's|common.loader=|common.loader="${catalina.base}/reports",|g' \
            /usr/local/tomcat/conf/catalina.properties
