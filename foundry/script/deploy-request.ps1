# TODO: UPDATE THESE FOUR CONSTANTS TO FIT YOUR PROJECT
$contractNames = @("Counter", "Storage")
$projectId = "<YOUR PROJECT'S ID>"
$chainId = 11155111
$apiKey = "<YOUR PROJECT'S API KEY>"

# Loki.code API URL
$lokiCodeUrl = "https://loki-api2.azurewebsites.net/deployment-requests/save"

# Directory containing the compiled contract data
$compileDir = "../out"

# Function to read contract data and send a POST request
function Send-DeployRequest {
    param (
        [string]$contractName,
        [string]$projectId,
        [int]$chainId,
        [string]$apiKey
    )

    $file = Join-Path $compileDir "$contractName.sol/$contractName.json"

    if (Test-Path $file) {
        # Extract abi and bytecode.object from the file using ConvertFrom-Json
        $json = Get-Content -Path $file | ConvertFrom-Json
        $abi = $json.abi | ConvertTo-Json -Compress
        $bytecode = $json.bytecode.object

        # Create JSON payload
        $payload = @{
            ContractData = @{
                abi = $abi
                bytecode = $bytecode
                contractName = $contractName
            }
            DeployOptions = @{
                projectId = $projectId
                chainId = $chainId
            }
        } | ConvertTo-Json -Compress

        # Send POST request
        $response = Invoke-RestMethod -Uri $lokiCodeUrl -Method Post -Headers @{ "Authorization" = "Bearer $apiKey"; "Content-Type" = "application/json" } -Body $payload -ErrorAction Stop
        $httpCode = $response.StatusCode
        $body = $response.Content

        if ($httpCode -eq 200 -or $httpCode -eq 201) {
            Write-Output "Response data: $body"
        }
        else {
            Write-Output "Error making POST request: HTTP $httpCode"
            Write-Output "Response: $body"
        }
    }
    else {
        Write-Output "Error: Contract file $file not found."
    }
}

# Main script
foreach ($contractName in $contractNames) {
    Send-DeployRequest -contractName $contractName -projectId $projectId -chainId $chainId -apiKey $apiKey
}
