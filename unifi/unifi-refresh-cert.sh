#!/bin/bash
#PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games'

openssl pkcs12 -export \
    -in /volume1/dockerdata/dnsrobocert/letsencrypt/live/unifi.teekens.info/fullchain.pem \
    -inkey /volume1/dockerdata/dnsrobocert/letsencrypt/live/unifi.teekens.info/privkey.pem \
    -out /volume1/dockerdata/dnsrobocert/letsencrypt/live/unifi.teekens.info/cert_and_key.p12 \
    -name tomcat -CAfile /volume1/dockerdata/dnsrobocert/letsencrypt/live/unifi.teekens.info/chain.pem \
    -caname root -password pass:aaa

rm -f /etc/letsencrypt/live/unifi.mydomain.com/keystore

keytool -importkeystore -srcstorepass aaa -deststorepass aircontrolenterprise -destkeypass aircontrolenterprise \
    -srckeystore /volume1/dockerdata/dnsrobocert/letsencrypt/live/unifi.teekens.info/cert_and_key.p12 \
    -srcstoretype PKCS12 \
    -alias tomcat \
    -keystore /volume1/dockerdata/dnsrobocert/letsencrypt/live/unifi.teekens.info/keystore

keytool -import -trustcacerts -alias unifi -deststorepass aircontrolenterprise \
    -file /volume1/dockerdata/dnsrobocert/letsencrypt/live/unifi.teekens.info/chain.pem \
    -noprompt \
    -keystore /volume1/dockerdata/dnsrobocert/letsencrypt/live/unifi.teekens.info/keystore

#mv /var/lib/unifi/keystore /var/lib/unifi/keystore-`date -I`

#cp /etc/letsencrypt/live/unifi.mydomain.com/keystore /var/lib/unifi/keystore

#service unifi restart