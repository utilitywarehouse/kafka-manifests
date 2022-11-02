# KRaft

With the release of Kafka [3.3.1](https://kafka.apache.org/downloads#3.3.1) KRaft is now marked production ready. There are several ways to set up a self-managed Kafka cluster in Kubernetes. We provide base manifests for three of them. These are:
* [combined](combined): in this mode a Kafka server acts both as a broker and controller. It's the simplest for development purposes. Not recommended for production.
* [dual](dual): in this mode each pod hosts two Kafka containers: one broker and one controller.
* [split](split): in this mode there are separate statefulsets for brokers and controllers.

More:
* [Documentation](https://kafka.apache.org/documentation.html#kraft)
