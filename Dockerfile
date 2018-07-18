FROM dwolla/jenkins-agent-core:debian
LABEL maintainer="Dwolla Dev <dev+jenkins-atlassian-sdk@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-atlassian-sdk"

USER root

RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       openjdk-8-jdk && \
    wget https://packages.atlassian.com/api/gpg/key/public && \
    sh -c 'echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list' && \
    apt-key add public && \
    apt-get update && \
    apt-get install atlassian-plugin-sdk && \
    apt-get clean && \
    rm public

USER jenkins

ENTRYPOINT ["jenkins-agent"]
