#!/usr/bin/env bash

# Start Wildfly with the given arguments.

# -Dorg.uberfire.nio.git.dir=/home/youruser/some/path - For setting the business central git to a share drive.
echo "Running business-central workbench on JBoss Wildfly..."
exec ./standalone.sh -b $JBOSS_BIND_ADDRESS -c $KIE_SERVER_PROFILE.xml    -Dorg.uberfire.nio.git.ssh.host=0.0.0.0 -Dorg.kie.demo=$KIE_DEMO -Dorg.kie.example=$KIE_DEMO -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true
exit $?