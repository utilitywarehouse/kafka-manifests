BITNAMI_KAFKA_RELEASE=22.1.1
VALUES_TLS="config/values-tls.yaml"

# to generate a new KRAFT_CLUSTERID:
# linux: cat /proc/sys/kernel/random/uuid | tr -d '-' | base64 | cut -b 1-22
# macos: uuidgen | tr -d '-' | base64 | cut -b 1-22

.PHONY: gen-pubsub-kafka-shared
gen-pubsub-kafka-shared:
	docker run -ti --rm \
	  -v $${PWD}:/opt/manifests \
	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
	  -e NS="pubsub" \
	  -e NAME="kafka-shared" \
	  -e KRAFT_CLUSTERID="k6fA260ZKAhRUMBN7aMApm" \
	  -e VALUES=${VALUES_TLS} \
	  --workdir=/opt/manifests \
	  --entrypoint=/bin/sh \
	  alpine/helm ./gen-yaml/gen
