ARG CORE_TAG

FROM dwolla/jenkins-agent-core:$CORE_TAG
LABEL maintainer="Dwolla Dev <dev+jenkins-atlassian-sdk@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-atlassian-sdk"

USER root
ARG SDK_VERSION="9.1.1"

COPY atlassian-plugin-sdk-${SDK_VERSION}.tar.gz /tmp

RUN tar -xvzf /tmp/atlassian-plugin-sdk-${SDK_VERSION}.tar.gz -C /opt && \
    rm /tmp/atlassian-plugin-sdk-${SDK_VERSION}.tar.gz && \
    mv /opt/atlassian-plugin-sdk-${SDK_VERSION}/ /opt/atlassian-plugin-sdk/

RUN chmod +x -R /opt/atlassian-plugin-sdk/
RUN export SDKMAN_DIR="${JENKINS_HOME}/.sdkman" && curl -s "https://get.sdkman.io" | bash

RUN chown -R jenkins:jenkins "${JENKINS_HOME}/.sdkman"

USER jenkins

ENV PATH="$PATH:/opt/atlassian-plugin-sdk/bin"

RUN source ~/.sdkman/bin/sdkman-init.sh && sdk install java 17.0.12-tem

ENTRYPOINT ["jenkins-agent"]
