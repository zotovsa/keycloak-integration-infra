#!/bin/bash

ip=$(grep `hostname` /etc/hosts | awk '{print $1}')

exec /keycloak/bin/standalone.sh --debug -c standalone-ha.xml -Djboss.bind.address.private=$ip -Djboss.bind.address=$ip -b 0.0.0.0 -Djboss.bind.address.management=0.0.0.0 -Djgroups.join_timeout=1000 -Djboss.default.jgroups.stack=kubernetes