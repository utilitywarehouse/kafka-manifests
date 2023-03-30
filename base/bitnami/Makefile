BITNAMI_KAFKA_RELEASE=21.4.2

.PHONY: gen-yaml
gen-yaml:
	docker run -ti --rm \
	-v $${PWD}:/opt/manifests \
        -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
        --workdir=/opt/manifests \
        --entrypoint=/bin/sh \
	alpine/helm ./gen-yaml
