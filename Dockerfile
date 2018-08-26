FROM openjdk:8
MAINTAINER gaurav sinha <sinha.kgaurav@gmail.com
# Add Maven dependencies (not shaded into the artifact; Docker-cached)
ADD target/*.war           /target/DevopsTask_image
# Add the service itself
ARG WAR_FILE
ADD target/*.war /