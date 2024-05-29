#!/bin/bash

# TODO: UPDATE THESE FOUR CONSTANTS TO FIT YOUR PROJECT
CONTRACT_NAMES=("Counter")  # Add more contract names as needed
PROJECT_ID="181"
CHAIN_ID=11155111
API_KEY="loki_jA1IQ_a305c502-79ad-4310-afcf-9808ed034c02_1724606904877"

# Loki.code API URL
LOKI_CODE_URL="https://loki-api2.azurewebsites.net/deployment-requests/save"

# Directory containing the compiled contract data
# COMPILE_DIR="out"
COMPILE_DIR="../out"

# Function to read contract data and send a POST request
send_deploy_request() {
    local contract_name=$1
    local project_id=$2
    local chain_id=$3
    local api_key=$4

    local file="$COMPILE_DIR/$contract_name.sol/$contract_name.json"

    if [[ -f "$file" ]]; then
        local abi=$(jq -r .abi "$file")
        local bytecode=$(jq -r .bytecode "$file")

        # Create JSON payload
        local payload=$(jq -n \
            --arg contractName "$contract_name" \
            --arg abi "$abi" \
            --arg bytecode "$bytecode" \
            --arg projectId "$project_id" \
            --argjson chainId "$chain_id" \
            '{
                ContractData: {
                    abi: $abi,
                    bytecode: $bytecode,
                    contractName: $contractName
                },
                DeployOptions: {
                    projectId: $projectId,
                    chainId: $chainId
                }
            }')

        # Send POST request
        local response=$(curl -s -w "\nHTTP_CODE:%{http_code}\n" -X POST "$LOKI_CODE_URL" \
            -H "Authorization: Bearer $api_key" \
            -H "Content-Type: application/json" \
            -d "$payload")

        local http_code=$(echo "$response" | grep -oP 'HTTP_CODE:\K\d+')
        local body=$(echo "$response" | sed '/HTTP_CODE:/d')

        if [[ "$http_code" -eq 200 ]]; then
            echo "Response data: $body"
        else
            echo "Error making POST request: HTTP $http_code"
            echo "Response: $body"
        fi
    else
        echo "Error: Contract file $file not found."
    fi
}

# Main script
for contract_name in "${CONTRACT_NAMES[@]}"; do
    send_deploy_request "$contract_name" "$PROJECT_ID" "$CHAIN_ID" "$API_KEY"
done
