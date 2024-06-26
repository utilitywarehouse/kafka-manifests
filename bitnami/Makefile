BITNAMI_KAFKA_RELEASE=22.1.1
VALUES_TLS="config/values-tls.yaml"
VALUES_NON_TLS="config/values-non-tls.yaml"

# to generate a new KRAFT_CLUSTERID:
# linux: cat /proc/sys/kernel/random/uuid | tr -d '-' | base64 | cut -b 1-22
# macos: uuidgen | tr -d '-' | base64 | cut -b 1-22

.PHONY: gen-otel-kafka
gen-otel-kafka:
	docker run -ti --rm \
	  -v $${PWD}:/opt/manifests \
	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
	  -e NS="otel" \
	  -e NAME="kafka-bitnami" \
	  -e KRAFT_CLUSTERID="MTkwQzczMTJCRUI1NEQ0N0" \
	  -e VALUES=${VALUES_TLS} \
	  --workdir=/opt/manifests \
	  --entrypoint=/bin/sh \
	  alpine/helm ./gen-yaml/gen

.PHONY: gen-pubsub-kafka-non-tls
gen-pubsub-kafka-non-tls:
	docker run -ti --rm \
	  -v $${PWD}:/opt/manifests \
	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
	  -e NS="pubsub" \
	  -e NAME="kafka-non-tls" \
	  -e KRAFT_CLUSTERID="MUE3RUU5Q0I5QzNCNEY1Mk" \
	  -e VALUES=${VALUES_NON_TLS} \
	  --workdir=/opt/manifests \
	  --entrypoint=/bin/sh \
	  alpine/helm ./gen-yaml/gen

.PHONY: gen-energy-bitnami-kafka-non-tls
gen-energy-kafka-non-tls:
	docker run -ti --rm \
	  -v $${PWD}:/opt/manifests \
	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
	  -e NS="energy" \
	  -e NAME="kafka-bitnami" \
	  -e KRAFT_CLUSTERID="NjY1Qjc2QTAwODU3NEE3Rk" \
	  -e VALUES=${VALUES_NON_TLS} \
	  --workdir=/opt/manifests \
	  --entrypoint=/bin/sh \
	  alpine/helm ./gen-yaml/gen

.PHONY: gen-energy-platform-bitnami-kafka-non-tls
gen-energy-platform-bitnami-kafka-non-tls:
	docker run -ti --rm \
	  -v $${PWD}:/opt/manifests \
	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
	  -e NS="energy-platform" \
	  -e NAME="kafka-bitnami" \
	  -e KRAFT_CLUSTERID="NTA2QzRCNkM0NUI4NEY0OU" \
	  -e VALUES=${VALUES_NON_TLS} \
	  --workdir=/opt/manifests \
	  --entrypoint=/bin/sh \
	  alpine/helm ./gen-yaml/gen

.PHONY: gen-finance-bitnami-kafka-non-tls
gen-finance-platform-bitnami-kafka-non-tls:
	docker run -ti --rm \
	  -v $${PWD}:/opt/manifests \
	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
	  -e NS="finance" \
	  -e NAME="kafka-bitnami" \
	  -e KRAFT_CLUSTERID="MzQ0MEVEQUUzRDg0NDdDNT" \
	  -e VALUES=${VALUES_NON_TLS} \
	  --workdir=/opt/manifests \
	  --entrypoint=/bin/sh \
	  alpine/helm ./gen-yaml/gen

.PHONY: gen-billing-bitnami-kafka-non-tls
gen-billing-platform-bitnami-kafka-non-tls:
	docker run -ti --rm \
	  -v $${PWD}:/opt/manifests \
	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
	  -e NS="billing" \
	  -e NAME="kafka-bitnami" \
	  -e KRAFT_CLUSTERID="RkU1NkQ2NkQwNTkxNDFEME" \
	  -e VALUES=${VALUES_NON_TLS} \
	  --workdir=/opt/manifests \
	  --entrypoint=/bin/sh \
	  alpine/helm ./gen-yaml/gen

.PHONY: gen-customer-billing-kafka-non-tls
gen-customer-billing-kafka-non-tls:
	docker run -ti --rm \
 	  -v $${PWD}:/opt/manifests \
 	  -e BITNAMI_KAFKA_RELEASE=${BITNAMI_KAFKA_RELEASE} \
 	  -e NS="customer-billing" \
 	  -e NAME="kafka-bitnami" \
 	  -e KRAFT_CLUSTERID="aCMuHORST5K9Rcvk-yWw7Q" \
 	  -e VALUES=${VALUES_NON_TLS} \
 	  --workdir=/opt/manifests \
 	  --entrypoint=/bin/sh \
 	  alpine/helm ./gen-yaml/gen
