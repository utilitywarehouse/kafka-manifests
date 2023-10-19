# kafka-manifests

This repository provides a kustomize base to deploy a kafka cluster

## Components

- Kafka
- Zookeeper
- lag-monitor
- [mirror-maker 2](mirror-maker-2)

## Versioning

Each component in this repo is versioned separately. These versions are managed
by tags having three components:

  - The name of the component
  - The version of the underlying image used in the manifests
  - An internal version to track changes to anything besides the version of the
  image used

These tags are of the form
`<component-name>-<image-version>-<internal-version>`, for example:
`kafka-ui-v0.7.1-1` is the first internal version of these manifests for the
`kafka-ui` component supporting `provectuslabs/kafka-ui:v0.7.1`
