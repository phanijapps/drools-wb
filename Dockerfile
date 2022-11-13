#########################################################################
# Dockerfile that provides the image for JBoss Business-Central Workbench
#########################################################################

####### BASE ############
FROM quay.io/wildfly/wildfly:23.0.2.Final



####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_VERSION 7.73.0.Final
ENV KIE_CLASSIFIER wildfly23
ENV KIE_CONTEXT_PATH business-central
ENV JAVA_OPTS -Xms256m -Xmx2048m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=512m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8
ENV KIE_SERVER_PROFILE standalone

####### JBPM-WB ############


#RUN curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/business-central/$KIE_VERSION/business-central-$KIE_VERSION-$KIE_CLASSIFIER.war && \
#unzip -q $HOME/$KIE_CONTEXT_PATH.war -d $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war &&  \
#touch $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \ 
#rm -rf $HOME/$KIE_CONTEXT_PATH.war
#Deploy the war file.



####### CONFIGURATION ############
USER root
ADD etc/start_business-central-wb.sh $JBOSS_HOME/bin/start_business-central-wb.sh

RUN chown jboss:jboss $JBOSS_HOME/bin/start_business-central-wb.sh
RUN chmod +x $JBOSS_HOME/bin/start_business-central-wb.sh


ADD business-central-7.73.0.Final-wildfly23.war $JBOSS_HOME/$KIE_CONTEXT_PATH.war
RUN unzip -q $JBOSS_HOME/$KIE_CONTEXT_PATH.war -d $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war
RUN touch $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy
RUN rm -rf $JBOSS_HOME/$KIE_CONTEXT_PATH.war

RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/*

####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss
RUN $JBOSS_HOME/bin/add-user.sh -a -u kieserver -p kieserver -ro admin,kie-server,rest-all

####### EXPOSE INTERNAL JBPM GIT PORT ############
EXPOSE 8001
EXPOSE 8080
EXPOSE 9990


####### RUNNING JBPM-WB ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_business-central-wb.sh"]