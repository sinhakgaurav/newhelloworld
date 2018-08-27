FROM tomcat:8.0
MAINTAINER gaurav sinha <sinha.kgaurav@gmail.com
# Add Maven dependencies (not shaded into the artifact; Docker-cached)
EXPOSE 8080

RUN rm -rf /usr/local/tomcat/webapps
COPY target/CounterWebApp /usr/local/tomcat/webapps/CounterWebApp