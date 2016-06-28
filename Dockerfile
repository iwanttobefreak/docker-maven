FROM oraclelinux:6.6

#Install software
RUN yum install -y tar

#Usuaris
RUN groupadd -g 1001 weblogic && useradd -u 1001 -g weblogic weblogic
RUN mkdir /u01 && chown weblogic. /u01
RUN echo "export JAVA_HOME=/u01/java" >> /home/weblogic/.bash_profile

#Descarrega programes
USER weblogic
RUN mkdir -p /u01/software && cd /u01/software && \
    curl -O http://apache.rediris.es/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
    tar -xzvf apache-maven-3.3.9-bin.tar.gz && mv apache-maven-3.3.9 ../maven && \
    curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0 Iceweasel/38.6.0" -b 'oraclelicense=accept-dbindex-cookie' -OL http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz && \
    tar -xzvf jdk-7u79-linux-x64.tar.gz && mv jdk1.7.0_79 ../java
RUN mkdir -p /u01/proyectos && cd /u01/proyectos && export JAVA_HOME=/u01/java && \
    /u01/maven/bin/mvn archetype:generate -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false -DgroupId=com.avanttic.prueba -DartifactId=appIC -Dpackage=com.avanttic.prueba
