# Kustomization base for Mirror Maker 2

## What is Mirror Maker?
Mirror Maker is the default tool to keep kafka clusters synchronized -> it can synchronize all data including consumer groups, acls, etc.

This is why it is also useful when migrating between clusters and even upgrading kafka to newer versions.

## Kustomization bases in this repo
 - [recommended: active-passive with SSL support](active-passive-ssl): this base uses a mirror-maker 2 [predefined configuration template](active-passive-ssl/config/connect-mirror-maker-template.properties) that is customised through environment variables. This is done in an init container. 
   The template is configured for an active-passive replication, and supports both SSL and non SSL enabled Kafka clusters. 
   mirror-maker 2 connects to SSL enabled Kafla clusters by using password encrypted JKS truststore and keystore. 
   With this base you can pass these passwords directly from Kubernetes secrets through environment variables.
- [flexible](flexible): this is a minimal base which is fully customizable through a properties file loaded from a ConfigMap. A [sample](flexible/config/connect-mirror-maker-sample.properties) showing the supported properties is included.

## References
- https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=27846330
- https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0
- https://cwiki.apache.org/confluence/display/KAFKA/KIP-545:+support+automated+consumer+offset+sync+across+clusters+in+MM+2.0
