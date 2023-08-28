BITNAMI_KAFKA_RELEASE=22.1.1
VALUES_TLS="config/values-tls.yaml"

.PHONY: gen-pubsub
gen-pubsub:
	docker run -ti --rm \
	  -v $${PWD}:/opt/manifests \
	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
	  -e NS="pubsub" \
	  -e VALUES=${VALUES_TLS} \
	  --workdir=/opt/manifests \
	  --entrypoint=/bin/sh \
	  alpine/helm ./gen-yaml