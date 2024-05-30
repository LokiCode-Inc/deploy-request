# Deploy Request Demo (Foundry)

A demo of using Loki.code's deploy request API call within a Foundry project. For a more detailed guide, check out our [docs](https://docs.lokicode.app/make-a-deploy-request).

## Getting Started

1. [Ensure you have a project on Loki.code](https://docs.lokicode.app/getting-started/how-to-create-a-new-project).
2. [Have your project's ID, and your project's API key at hand](https://docs.lokicode.app/make-a-deploy-request#step-1-generate-an-api-key).

## Send a Deploy Request (MacOS or Linux)

1. Optional: add your contracts to the [src](/foundry/src/) folder.
2. Edit the [deploy-request script](/foundry/script/deploy-request.sh) (follow the instructions at the top of that file).
3. Run `forge build` to compile your contracts.
4. Install the `jq` package if you don't have it already. You can install it with `brew install jq` on MacOS or `sudo apt-get install jq` on Linux.
5. Run `chmod +x script/deploy-request.sh` to make the deploy request script executable.
6. Run `./script/deploy-request.sh` to send the deploy request.
7. Go to your project on Loki.code's website to review the deploy request.
