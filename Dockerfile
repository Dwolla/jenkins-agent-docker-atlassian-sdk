FROM dwolla/jenkins-agent-core:debian
LABEL maintainer="Dwolla Dev <dev+jenkins-atlassian-sdk@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-atlassian-sdk"

USER root

RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       gnupg && \
    curl -o adoptopenjdk.pub https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public && \
    apt-key add adoptopenjdk.pub && \
    echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb buster main" | tee /etc/apt/sources.list.d/adoptopenjdk.list && \
    apt-get update && \
    apt-get install -y adoptopenjdk-8-hotspot && \
    curl -o atlassian.pub https://packages.atlassian.com/api/gpg/key/public && \
    sh -c 'echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list' && \
    apt-key add atlassian.pub && \
    apt-get update && \
    apt-get install atlassian-plugin-sdk && \
    apt-get clean && \
    rm atlassian.pub adoptopenjdk.pub

USER jenkins

ENTRYPOINT ["jenkins-agent"]
