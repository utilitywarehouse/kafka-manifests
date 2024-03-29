# kafka-ui kustomization base

This folder contains a kustomization base for [kafka-ui](https://github.com/provectus/kafka-ui).

## How to use
This base contains an empty configuration with commented out samples. See the [config](config) folder.

The config files are loaded through a [generated ConfigMap](https://github.com/utilitywarehouse/kafka-manifests/blob/75d31cd84633ffb36c7c7618dc725110b0d4c82c/kafka-ui/kustomization.yaml#L7-L12) into the pod and passed through
[the environment variable SPRING_CONFIG_ADDITIONAL-LOCATION as config files](https://github.com/utilitywarehouse/kafka-manifests/blob/75d31cd84633ffb36c7c7618dc725110b0d4c82c/kafka-ui/app.yaml#L41-L45) to Spring Boot.

**NOTE**: If you need to add more files to the ConfigMap, this environment variable will need to be adjusted accordingly.

When using this base you'll need to fill in the configuration files with what suits you and replace the ConfigMap in the final kustomization file: 
```yaml
configMapGenerator:
  - name: kafka-ui-config
    behavior: replace
    files:
      - rbac.yaml=./config/rbac.yaml
      - auth.yaml=./config/auth.yaml
      - clusters.yaml=./config/clusters.yaml
```
