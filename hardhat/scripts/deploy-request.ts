/**
 * @fileoverview This script sends a deploy request to your Loki.code project.
 *
 * Step 1: Optional: add your contracts to the /contracts folder.
 *
 * Step 2: Edit the following constants in the main function below:
 * @constant contractNames: The names of the contracts you wish to make a deploy request for.
 * @constant projectId: The ID of the project you wish to save the deploy request to. You can find this on your project's page on Loki.
 * @constant chainId: The ID of the chain you wish to deploy to (i.e. 1 for mainnet).
 * @constant apiKey: Your Loki.code API key. You can generate this from your project's page on Loki.code.
 *
 * Step 3: Run the following command in your terminal:
 * npx hardhat run scripts/deploy-request.ts
 */

import hre from "hardhat";
import axios from "axios";

interface ContractData {
  abi: any;
  bytecode: string;
  contractName: string;
}

interface DeployOptions {
  projectId: string;
  chainId: number;
}

interface RequestBody {
  ContractData: ContractData;
  DeployOptions: DeployOptions;
}

async function deployRequest(
  contractNames: string[],
  projectId: string,
  chainId: number,
  apiKey: string
): Promise<void> {
  const lokicodeUrl =
    "https://loki-api2.azurewebsites.net/deployment-requests/save";

  for (const contractName of contractNames) {
    try {
      const contractArtifact = await hre.artifacts.readArtifact(contractName);
      const { abi, bytecode } = contractArtifact;

      const contractData: ContractData = { abi, bytecode, contractName };
      const deployOptions: DeployOptions = { projectId, chainId };
      const body: RequestBody = {
        ContractData: contractData,
        DeployOptions: deployOptions,
      };

      try {
        const response = await axios.post(lokicodeUrl, body, {
          headers: {
            Authorization: `Bearer ${apiKey}`,
            "Content-Type": "application/json",
          },
        });
        console.log("Response data:", response.data);
      } catch (error) {
        console.error("Error making POST request:", error);
      }
    } catch (error) {
      console.error("Error reading contract artifact:", error);
    }
  }
}

async function main(): Promise<void> {
  // TODO: UPDATE THESE FOUR CONSTANTS TO FIT YOUR PROJECT
  const contractNames = ["Storage", "Lock"];
  const projectId = "<YOUR PROJECT'S ID>";
  const chainId = 11155111;
  const apiKey = "<YOUR PROJECT'S API KEY>";

  try {
    await deployRequest(contractNames, projectId, chainId, apiKey);
  } catch (error) {
    console.error("Error deploying contract:", error);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
