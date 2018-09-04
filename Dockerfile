FROM tomcat:8.0
MAINTAINER gaurav sinha <kumar.sinha@nagarro.com>
# Add Maven dependencies (not shaded into the artifact; Docker-cached)
EXPOSE 8080 7080

RUN rm -rf /usr/local/tomcat/webapps
COPY target/CounterWebApp /usr/local/tomcat/webapps/CounterWebApp/