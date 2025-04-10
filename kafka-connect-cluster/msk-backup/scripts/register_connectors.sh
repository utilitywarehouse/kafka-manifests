#!/bin/sh

CONNECTOR_REGISTRATION_ENDPOINT="${KAFKA_CONNECT_API_HOST:-http://localhost:8083}/connectors"
CONNECTOR_CONFIG_DIR="${CONNECTOR_CONFIG_DIR:-/config/connectors}"

if [ ! -d "$CONNECTOR_CONFIG_DIR" ]; then
  echo "Error: Connector payload folder '$CONNECTOR_CONFIG_DIR' does not exist."
  exit 1
fi

echo "Waiting for Kafka Connect REST API..."
while ! curl -s "$CONNECTOR_REGISTRATION_ENDPOINT" > /dev/null; do
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

  # convert to json from yaml before sending to the kafka connect API as that's the only accepted format
  resp=$(yq -o=json "${payload_file}" | curl -s -w "\n%{http_code}" \
    -X POST -H "Content-Type: application/json" \
    --data @- "$CONNECTOR_REGISTRATION_ENDPOINT")

  rbody=$(echo "$resp" | sed '$d')
  rcode=$(echo "$resp" | tail -n 1)

  if [ "$rcode" -eq 409 ]; then
    echo "Connector '$connector_name' already registered. Skipping."
  elif [ "$rcode" -ge 200 ] && [ "$rcode" -lt 300 ]; then
    echo "Connector '$connector_name' registered successfully!"
  else
    echo "Failed to register connector '$connector_name'. HTTP status code: $rcode"
    echo "$rbody"
  fi
done

echo "Connector registration process completed."
