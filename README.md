# SBC NFT Minting

This contract is for minting of SBC NFTs. The blank pendant is filled with user's custom NFT by updating metadata of the NFT with description as JSON file.

Try running some of the following tasks:

To install all dependancies, run the following command
```shell
yarn install
```

To compile the contract, try this
```
yarn hardhat compile
```

For deploying the contract to Sepolia testnet
```
yarn hardhat run ./scripts/minting.ts --network sepolia
```
or to Ethereum mainnet
```
yarn hardhat run ./scripts/minting.ts --network mainnet
```

For verifying the contract
```
yarn hardhat verify <deployed contract address> SBC_minting SBC_minting --network sepolia
```

