# Jenkins Agent with atlassian-sdk

Docker image based on [Dwolla's core Jenkins Agent](https://github.com/Dwolla/jenkins-agent-docker-core) adding the [atlassian-sdk](https://developer.atlassian.com/server/framework/atlassian-sdk/)

## Local Development

With [yq](https://kislyuk.github.io/yq/) installed, to build this image locally run the following command:

```bash
make \
    CORE_JDK8_TAG=$(curl --silent https://raw.githubusercontent.com/Dwolla/jenkins-agents-workflow/main/.github/workflows/build-docker-image.yml | \
        yq .jobs.\"build-core-matrix\".strategy.matrix.TAG | yq '.[] | select (test(".*?jdk8.*?"))') \
    CORE_JDK11_TAG=$( curl --silent https://raw.githubusercontent.com/Dwolla/jenkins-agents-workflow/main/.github/workflows/build-docker-image.yml | \
        yq .jobs.\"build-core-matrix\".strategy.matrix.TAG | yq '.[] | select (test(".*?jdk11.*?"))') \
    all
```

Alternatively, without [yq](https://kislyuk.github.io/yq/) installed, refer to the CORE_TAG default values defined in [jenkins-agents-workflow](https://github.com/Dwolla/jenkins-agents-workflow/blob/main/.github/workflows/build-docker-image.yml) and run the following command:

`make JDK11_TAG=<default-core-jdk11-tag-from-jenkins-agents-workflow> JDK8_TAG=<default-core-jdk8-tag-from-jenkins-agents-workflow> all`