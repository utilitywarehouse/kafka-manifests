# Bitnami based manifests

Creates a base from bitnami helm charts with minimal configuration

`shared` contains kustomize bases that can be reused across namespaces
`config` contains configuration files pass to the bitnami helm charts
* currently contains the configuration for setting up a cluster with tls enabled

`Makefile` contains targets for each of the namespaces we want to create a base for
* executing each target generates a kustomize base that is specific to each namespace which can be readily deployed


To add a base for a new kafka cluster:
* add a target to the Makefile
    * `NS` - namespace where the cluster will be deployed
    * `NAME` - the k8s resources in the generated base will be prefixed with this
    * `KRAFT_CLUSTERID`
    *  `VALUES` - path to one of the files inside `config`
```
# to generate a new KRAFT_CLUSTERID:
# linux: cat /proc/sys/kernel/random/uuid | tr -d '-' | base64 | cut -b 1-22
# macos: uuidgen | tr -d '-' | base64 | cut -b 1-22

.PHONY: gen-pubsub
gen-pubsub:
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
```
    
* execute the target - this will create a new dir containing the base
```
pubsub
└── kafka-shared
    ├── kustomization.yaml
    └── upstream
        ├── kafka.yaml
        └── kustomization.yaml
```
* add more resources to be base if needed
* PR the changes
* use the new base in `kubernetes-manifests`

## Monitoring

For clusters using these manfiests, there are Grafana dashboards available for:

  - A general overview:
      - [`dev-aws`](https://grafana.dev.aws.uw.systems/d/qoF35R8Vk/bitnami-kafka-overview?from=now-24h&to=now&var-datasource=default&var-namespace=pubsub&var-topic=All&var-consumergroup=All&orgId=1&refresh=1m)
      - [`dev-gcp`](https://grafana.dev.gcp.uw.systems/d/qoF35R8Vk/bitnami-kafka-overview?from=now-24h&to=now&var-datasource=default&var-namespace=pubsub&var-topic=All&var-consumergroup=All&orgId=1&refresh=1m)
      - [`dev-merit`](https://grafana.dev.merit.uw.systems/d/qoF35R8Vk/bitnami-kafka-overview?from=now-24h&to=now&var-datasource=default&var-namespace=pubsub&var-topic=All&var-consumergroup=All&orgId=1&refresh=1m)
      - [`prod-aws`](https://grafana.prod.aws.uw.systems/d/qoF35R8Vk/bitnami-kafka-overview?from=now-24h&to=now&var-datasource=default&var-namespace=pubsub&var-topic=All&var-consumergroup=All&orgId=1&refresh=1m)
      - [`prod-gcp`](https://grafana.prod.gcp.uw.systems/d/qoF35R8Vk/bitnami-kafka-overview?from=now-24h&to=now&var-datasource=default&var-namespace=pubsub&var-topic=All&var-consumergroup=All&orgId=1&refresh=1m)
      - [`prod-merit`](https://grafana.prod.merit.uw.systems/d/qoF35R8Vk/bitnami-kafka-overview?from=now-24h&to=now&var-datasource=default&var-namespace=pubsub&var-topic=All&var-consumergroup=All&orgId=1&refresh=1m)
  - Topic and consumer group stats
      - [`dev-aws`](https://grafana.dev.aws.uw.systems/d/54voygUVz/bitnami-kafka-topics-and-consumer-group-stats?orgId=1&refresh=1m&var-datasource=default&var-namespace=pubsub&var-topic=All)
      - [`dev-gcp`](https://grafana.dev.gcp.uw.systems/d/54voygUVz/bitnami-kafka-topics-and-consumer-group-stats?orgId=1&refresh=1m&var-datasource=default&var-namespace=pubsub&var-topic=All)
      - [`dev-merit`](https://grafana.dev.merit.uw.systems/d/54voygUVz/bitnami-kafka-topics-and-consumer-group-stats?orgId=1&refresh=1m&var-datasource=default&var-namespace=pubsub&var-topic=All)
      - [`prod-aws`](https://grafana.prod.aws.uw.systems/d/54voygUVz/bitnami-kafka-topics-and-consumer-group-stats?orgId=1&refresh=1m&var-datasource=default&var-namespace=pubsub&var-topic=All)
      - [`prod-gcp`](https://grafana.prod.gcp.uw.systems/d/54voygUVz/bitnami-kafka-topics-and-consumer-group-stats?orgId=1&refresh=1m&var-datasource=default&var-namespace=pubsub&var-topic=All)
      - [`prod-merit`](https://grafana.prod.merit.uw.systems/d/54voygUVz/bitnami-kafka-topics-and-consumer-group-stats?orgId=1&refresh=1m&var-datasource=default&var-namespace=pubsub&var-topic=All)
