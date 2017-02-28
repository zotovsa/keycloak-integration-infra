openssl genrsa -out rootCA.key 4096
openssl req -x509 -new -key rootCA.key -days 10000 -out rootCA.crt

keytool -import -alias root -keystore keycloak.jks -trustcacerts -file rootCA.crt -storepass 123456
keytool -genkey -alias tomcat -keyalg RSA -keystore keycloak.jks -storepass 123456
keytool -certreq -keyalg RSA -alias tomcat -file keycloak.csr -keystore keycloak.jks  -storepass 123456
openssl x509 -req -sha256 -in keycloak.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out keycloak.crt -days 5000
keytool -import -alias tomcat -keystore keycloak.jks  -file keycloak.crt -storepass 123456

keytool -import -alias root -keystore hello-annotation-service.jks -trustcacerts -file rootCA.crt -storepass 123456
keytool -genkey -alias hello-annotation-service -keyalg RSA  -keystore hello-annotation-service.jks  -storepass 123456
keytool -certreq -keyalg RSA -alias hello-annotation-service -file hello-annotation-service.csr -keystore hello-annotation-service.jks  -storepass 123456
openssl x509 -req -sha256 -in hello-annotation-service.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out hello-annotation-service.crt -days 5000
keytool -import -alias hello-annotation-service -keystore hello-annotation-service.jks  -file hello-annotation-service.crt -storepass 123456

keytool -import -alias root -keystore hello-data-service.jks -trustcacerts -file rootCA.crt -storepass 123456
keytool -genkey -alias hello-data-service -keyalg RSA  -keystore hello-data-service.jks -storepass 123456
keytool -certreq -keyalg RSA -alias hello-data-service -file hello-data-service.csr -keystore hello-data-service.jks -storepass 123456
openssl x509 -req -sha256 -in hello-data-service.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out hello-data-service.crt -days 5000
keytool -import -alias hello-data-service -keystore hello-data-service.jks -file hello-data-service.crt -storepass 123456

keytool -import -alias root -keystore permission-service.jks -trustcacerts -file rootCA.crt -storepass 123456
keytool -genkey -alias permission-service -keyalg RSA  -keystore permission-service.jks -storepass 123456
keytool -certreq -keyalg RSA -alias permission-service -file permission-service.csr -keystore permission-service.jks -storepass 123456
openssl x509 -req -sha256 -in permission-service.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out permission-service.crt -days 5000
keytool -import -alias permission-service -keystore permission-service.jks  -file permission-service.crt -storepass 123456

openssl req -new -newkey rsa:2048 -nodes -keyout nginx.key -out nginx.csr
openssl x509 -req -sha256 -in nginx.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out nginx.crt -days 5000