# Split mode

In this mode, the Kafka cluster is made of two separate statefulsets. One for brokers and another for controllers.
When updating common server configs / kafka versions, it's recommended to update them separately. Further experimentation is needed to understand the impact of two cluster members being down at the same time, if any.

## Deployment

1. Generate a new cluster token

```bash
$ docker run -ti quay.io/utilitywarehouse/uw-kafka:v3.3.1 sh -- ./kafka-storage.sh random-uuid
B3PgICDlRNiGaaqnEPSQ6w
```

2. Update broker and controller container cmd by setting CLUSTER_ID to the above generated token.
3. Apply the resource manifests.
