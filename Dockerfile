FROM jboss/wildfly:8.2.1.Final

RUN mkdir /opt/jboss/wildfly/modules/system/layers/base/org/postgresql

RUN mkdir /opt/jboss/despesas_index

RUN chmod 777 /opt/jboss/despesas_index

COPY image-build/postgresql/ /opt/jboss/wildfly/modules/system/layers/base/org/postgresql

COPY image-build/standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml

ADD despesas-ear/target/despesas.ear /opt/jboss/wildfly/standalone/deployments/