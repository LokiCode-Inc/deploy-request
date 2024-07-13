# Deploy Request Demo (Foundry)

A demo of using Loki.code's deploy request API call within a Foundry project. For a more detailed guide, check out our [docs](https://docs.lokicode.app/make-a-deploy-request).

## Getting Started

1. [Ensure you have a project on Loki.code](https://docs.lokicode.app/getting-started/how-to-create-a-new-project).
2. [Ensure you have Foundry installed on your machine](https://book.getfoundry.sh/getting-started/installation).
3. [Have your project's ID, and your project's API key at hand](https://docs.lokicode.app/make-a-deploy-request#step-1-generate-an-api-key).

## Send a Deploy Request (MacOS or Linux)

1. Optional: add your contracts to the [src](/foundry/src/) folder.
2. Run `forge build` to compile your contracts.
3. Edit the [deploy-request script](/foundry/script/deploy-request.sh) (follow the instructions at the top of that file).
4. Install the `jq` package if you don't have it already. You can install it with `brew install jq` on MacOS or `sudo apt-get install jq` on Linux.
5. Run `cd script` to enter the script directory.
6. Run `chmod +x deploy-request.sh` to make the deploy request script executable.
7. Run `./deploy-request.sh` to send the deploy request.
8. Go to your project on Loki.code's website to review the deploy request.

## Send a Deploy Request (Windows)

1. Optional: add your contracts to the [src](/foundry/src/) folder.
2. Edit the [deploy-request script](/foundry/script/deploy-request.ps1) (follow the instructions at the top of that file).
3. Run `forge build` to compile your contracts.
4. Run `.\deploy-request.ps1` to send the deploy request.
5. Go to your project on Loki.code's website to review the deploy request.
