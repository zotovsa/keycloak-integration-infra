FROM azul/zulu-openjdk:8

VOLUME /tmp
ENTRYPOINT ["java","-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=7091","-Djava.library.path=/usr/local/apr/lib","-jar","/app.jar"]
ADD hello-annotations-service-1.0.0-SNAPSHOT.jar /app.jar
RUN apt-get update
RUN apt-get install --assume-yes wget && apt-get install --assume-yes build-essential && apt-get install libssl-dev --assume-yes
RUN wget http://www-us.apache.org/dist/apr/apr-1.5.2.tar.gz
RUN tar -zxvf apr-1.5.2.tar.gz
RUN cd apr-1.5.2 && ./configure && make && make install
RUN wget http://www-us.apache.org/dist/apr/apr-util-1.5.4.tar.gz
RUN tar -zxvf apr-util-1.5.4.tar.gz
RUN cd apr-util-1.5.4 && ./configure --with-apr=/usr/local/apr && make && make install
RUN wget http://www-eu.apache.org/dist/tomcat/tomcat-connectors/native/1.2.12/source/tomcat-native-1.2.12-src.tar.gz
RUN tar xzf tomcat-native-1.2.12-src.tar.gz
RUN cd tomcat-native-1.2.12-src/native && ./configure --with-apr=/usr/local/apr --with-java-home=/usr/lib/jvm/zulu-8-amd64 --with-ssl=yes && make && make install
RUN export LD_LIBRARY_PATH=/usr/local/apr/lib
RUN sh -c 'touch /app.jar'

ADD rootCA.crt /keycloak/rootCA.crt
RUN /usr/lib/jvm/zulu-8-amd64/bin/keytool -importcert -noprompt -alias rootcert1 -keystore /usr/lib/jvm/zulu-8-amd64/jre/lib/security/cacerts -storepass changeit -file /keycloak/rootCA.crt

EXPOSE 7091 9290 

