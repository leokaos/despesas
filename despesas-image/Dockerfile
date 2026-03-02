FROM jboss/wildfly:8.2.1.Final

# Cria a pasta despesas_index com as permissões especificadas
USER root
RUN mkdir -p /opt/jboss/despesas_index && \
    chown jboss:jboss /opt/jboss/despesas_index && \
    chmod 777 /opt/jboss/despesas_index

USER root
RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/org/postgresql && \
    chown jboss:jboss /opt/jboss/wildfly/modules/system/layers/base/org/postgresql && \
    chmod 777 /opt/jboss/wildfly/modules/system/layers/base/org/postgresql

# Volta para o usuário jboss (padrão da imagem)
USER jboss

COPY postgresql/ /opt/jboss/wildfly/modules/system/layers/base/org/postgresql

COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml

ADD despesas.ear /opt/jboss/wildfly/standalone/deployments/