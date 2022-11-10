# Combined mode

In this mode a Kafka server acts both as a broker and controller. It's the simplest for development purposes.
As the broker and controller processes run on the same kafka server, an OOM brings down both. Not meant for production use.

## Deployment

1. Generate a new cluster token

```bash
$ docker run -ti quay.io/utilitywarehouse/uw-kafka:v3.3.1 sh -- ./kafka-storage.sh random-uuid
B3PgICDlRNiGaaqnEPSQ6w
```

2. Update broker container cmd by setting CLUSTER_ID to the above generated token.
3. Apply the resource manifests.
