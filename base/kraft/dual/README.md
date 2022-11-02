# Dual mode

In this mode, there are two Kafka containers in every pod. One running as a broker and the other as a controller server.
Disadvantages:
* can't scale separately
* pod resource requirements are doubled
* pod restarts bring down both servers, essentially taking out two cluster members at the same time. Further experimentation is needed to understand the impact of this.

## Deployment

1. Generate a new cluster token

```bash
$ docker run -ti quay.io/utilitywarehouse/uw-kafka:v3.3.1 sh -- ./kafka-storage.sh random-uuid
B3PgICDlRNiGaaqnEPSQ6w
```

2. Update broker and controller container cmd by setting CLUSTER_ID to the above generated token.
3. Apply the resource manifests.
