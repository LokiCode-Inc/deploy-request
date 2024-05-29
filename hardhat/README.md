# Deploy Request Demo (Hardhat)

A demo of using Loki.code's deploy request API call within a Hardhat project. For a more detailed guide, check out our [docs](https://docs.lokicode.app/make-a-deploy-request).

## Getting Started

1. Run `npm install`.
2. [Ensure you have a project on Loki.code](https://docs.lokicode.app/getting-started/how-to-create-a-new-project).
3. [Have your project's ID, and your project's API key at hand](https://docs.lokicode.app/make-a-deploy-request#step-1-generate-an-api-key).

## Send a Deploy Request

1. Optional: add your contracts to the [contracts](/hardhat/contracts/) folder.
2. Edit the [deploy-request script](/hardhat/scripts/deploy-request.ts) (follow the instructions at the top of that file).
3. Run `npx hardhat run scripts/deploy-request.ts`.
4. Go to your project on Loki.code's website to review the deploy request.
