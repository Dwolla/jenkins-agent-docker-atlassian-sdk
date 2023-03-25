CORE_TAG := $(CORE_JDK11_TAG)
JOB := core-${CORE_TAG}
CLEAN_JOB := clean-${CORE_TAG}

all: ${JOB}
clean: ${CLEAN_JOB}
.PHONY: all clean ${JOB} ${CLEAN_JOB}

${JOB}: core-%: Dockerfile
	docker buildx build \
	  --platform linux/arm64,linux/amd64 \
	  --build-arg CORE_TAG=$* \
	  --tag dwolla/jenkins-agent-atlassian-sdk:$*-SNAPSHOT \
	  .

${CLEAN_JOB}: clean-%:
	docker rmi -f dwolla/jenkins-agent-atlassian-sdk:$*-SNAPSHOT