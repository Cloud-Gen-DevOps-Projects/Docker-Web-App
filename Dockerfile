FROM tomcat:latest
MAINTAINER ravindra ravindra.devops@gmail.com
COPY cloudgen.war /usr/local/tomcat/webapps
EXPOSE 8080

