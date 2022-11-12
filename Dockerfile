FROM quay.io/kiegroup/business-central-workbench:latest

#Env variables
ENV KIE_SSH_HOST 0.0.0.0

#Replace start business central
USER root
COPY start_business-central-wb.sh /opt/jboss/wildfly/bin/start_business-central-wb.sh
RUN chown jboss:jboss /opt/jboss/wildfly/bin/start_business-central-wb.sh
RUN chmod +x /opt/jboss/wildfly/bin/start_business-central-wb.sh

####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss

####### EXPOSE INTERNAL JBPM GIT PORT ############
EXPOSE 8001

####### RUNNING JBPM-WB ############
WORKDIR /opt/jboss/wildfly/bin/
CMD ["./start_business-central-wb.sh"]