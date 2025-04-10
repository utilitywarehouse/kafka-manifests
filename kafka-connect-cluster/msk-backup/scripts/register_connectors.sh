#!/bin/sh

CONNECTORS_ENDPOINT="${KAFKA_CONNECT_API_HOST:-http://localhost:8083}/connectors"
CONNECTOR_CONFIG_DIR="${CONNECTOR_CONFIG_DIR:-/config/connectors}"

if [ ! -d "$CONNECTOR_CONFIG_DIR" ]; then
  echo "Error: Connector payload folder '$CONNECTOR_CONFIG_DIR' does not exist."
  exit 1
fi

echo "Waiting for Kafka Connect REST API..."
while ! curl -s "$CONNECTORS_ENDPOINT" > /dev/null; do
  echo "Kafka Connect REST API is not available yet. Retrying in 5 seconds..."
  sleep 5
done

echo "Kafka Connect REST API is available. Starting connector registration process."

for payload_file in "$CONNECTOR_CONFIG_DIR"/*.yaml; do
  if [ ! -f "$payload_file" ]; then
    echo "No YAML files found in $CONNECTOR_CONFIG_DIR. Skipping."
    break
  fi

  connector_name=$(yq -r '.name' "$payload_file")
  if [ -z "$connector_name" ] || [ "$connector_name" == "null" ]; then
    echo "Skipping $payload_file: Missing or invalid connector payload."
    continue
  fi

  echo "Registering connector: $connector_name using payload file: $payload_file"

  config_endpoint="${CONNECTORS_ENDPOINT}/${connector_name}/config"

  # convert to json from yaml before sending to the kafka connect API as that's the only accepted format
  resp=$(yq -r '.config' -o=json "${payload_file}" | curl -s -w "\n%{http_code}" \
    -X PUT -H "Content-Type: application/json" \
    --data @- "${config_endpoint}")

  rbody=$(echo "$resp" | sed '$d')
  rcode=$(echo "$resp" | tail -n 1)

  if [ "$rcode" -ge 200 ] && [ "$rcode" -lt 300 ]; then
    echo "Connector '$connector_name' registered successfully!"
  else
    echo "Failed to register connector '$connector_name'. HTTP status code: $rcode"
    echo "$rbody"
    exit 1
  fi
done

echo "Connector registration process completed."
