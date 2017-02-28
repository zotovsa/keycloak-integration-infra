FROM azul/zulu-openjdk:8

RUN apt-get update
RUN apt-get --assume-yes install wget
RUN wget https://downloads.jboss.org/keycloak/2.5.4.Final/keycloak-2.5.4.Final.tar.gz
RUN tar -xzvf keycloak-2.5.4.Final.tar.gz && mv keycloak-2.5.4.Final keycloak
COPY standalone.xml /keycloak/standalone/configuration/standalone.xml
COPY keycloak.jks /keycloak/standalone/configuration
RUN /keycloak/bin/add-user-keycloak.sh -u admin -p admin
COPY ad-integration-module-1.0.0.jar /keycloak/providers/ad-integration-module.jar
COPY realm-identity-provider-ad-oidc.html /keycloak/themes/base/admin/resources/partials/realm-identity-provider-ad-oidc.html
COPY realm-identity-provider-keycloak-ad-oidc.html /keycloak/themes/base/admin/resources/partials/realm-identity-provider-keycloak-ad-oidc.html
ADD jgroups-protocols.tar.gz /keycloak/modules/system/layers/base/org/jgroups-protocols.tar.gz
ADD rootCA.crt /keycloak/rootCA.crt
RUN /usr/lib/jvm/zulu-8-amd64/bin/keytool -importcert -noprompt -alias rootcert1 -keystore /usr/lib/jvm/zulu-8-amd64/jre/lib/security/cacerts -storepass changeit -file /keycloak/rootCA.crt
CMD exec ./keycloak/bin/standalone.sh -b 0.0.0.0 -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0
EXPOSE 8080 8443 9990