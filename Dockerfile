ARG CORE_TAG

FROM dwolla/jenkins-agent-core:$CORE_TAG
LABEL maintainer="Dwolla Dev <dev+jenkins-atlassian-sdk@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/jenkins-agent-atlassian-sdk"

USER root

RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       gnupg && \
    apt-get update && \
    curl -o atlassian.pub https://packages.atlassian.com/api/gpg/key/public && \
    sh -c 'echo "deb [arch=amd64] https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list' && \
    apt-key add atlassian.pub && \
    apt-get update && \
    apt-get install atlassian-plugin-sdk && \
    apt-get clean && \
    rm atlassian.pub

USER jenkins

ENTRYPOINT ["jenkins-agent"]
