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

for CONFIG_FILE in "$CONNECTOR_CONFIG_DIR"/*.json; do
  if [ ! -f "$CONFIG_FILE" ]; then
    echo "No JSON files found in $CONNECTOR_CONFIG_DIR. Skipping."
    break
  fi

  CONNECTOR_NAME=$(jq -r '.name' "$CONFIG_FILE")
  if [ -z "$CONNECTOR_NAME" ] || [ "$CONNECTOR_NAME" == "null" ]; then
    echo "Skipping $CONFIG_FILE: Missing or invalid connector payload."
    continue
  fi

  echo "Registering connector: $CONNECTOR_NAME using payload file: $CONFIG_FILE"

  RESPONSE=$(curl -s -w "\n%{http_code}" \
    -X POST -H "Content-Type: application/json" \
    --data @"$CONFIG_FILE" "$CONNECTOR_REGISTRATION_ENDPOINT")

  RESPONSE_BODY=$(echo "$RESPONSE" | sed '$d')
  RESPONSE_CODE=$(echo "$RESPONSE" | tail -n 1)

  if [ "$RESPONSE_CODE" -eq 409 ]; then
    echo "Connector '$CONNECTOR_NAME' already registered. Skipping."
  elif [ "$RESPONSE_CODE" -ge 200 ] && [ "$RESPONSE_CODE" -lt 300 ]; then
    echo "Connector '$CONNECTOR_NAME' registered successfully!"
  else
    echo "Failed to register connector '$CONNECTOR_NAME'. HTTP status code: $RESPONSE_CODE"
    echo "$RESPONSE_BODY"
  fi
done

echo "Connector registration process completed."
