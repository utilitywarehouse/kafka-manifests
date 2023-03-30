KMINION_RELEASE=v2.2.3

.PHONY: gen-yaml
gen-yaml:
	docker run -ti --rm \
	-v $${PWD}:/opt/manifests \
        -e KMINION_RELEASE=${KMINION_RELEASE} \
        --workdir=/opt/manifests \
        --entrypoint=/bin/sh \
	alpine/helm ./gen-yaml
