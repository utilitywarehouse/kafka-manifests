# Combined mode

In this mode a Kafka server acts both as a broker and controller. It's the simplest for development purposes.
As the broker and controller processes run on the same kafka server, an OOM brings down both. Not meant for production use[[1]](#Refs).

## Deployment

1. Generate a new cluster token

```bash
$ docker run -ti quay.io/utilitywarehouse/uw-kafka:v3.3.1 sh -- ./kafka-storage.sh random-uuid
B3PgICDlRNiGaaqnEPSQ6w
```

2. Update broker container cmd by setting CLUSTER_ID to the above generated token.
3. Apply the resource manifests.


## Refs

[1]
* https://kafka.apache.org/documentation/#kraft_role
> Kafka servers that act as both brokers and controllers are referred to as "combined" servers. Combined servers are simpler to operate for small use cases like a development environment. The key disadvantage is that the controller will be less isolated from the rest of the system. For example, it is not possible to roll or scale the controllers separately from the brokers in combined mode. Combined mode is not recommended in critical deployment environments.

* https://kafka.apache.org/documentation/#kraft_deployment
> Kafka server's process.role should be set to either broker or controller but not both. Combined mode can be used in development environments, but it should be avoided in critical deployment environments.

> For redundancy, a Kafka cluster should use 3 controllers. More than 3 servers is not recommended in critical environments. In the rare case of a partial network failure it is possible for the cluster metadata quorum to become unavailable. This limitation will be addressed in a future release of Kafka.
