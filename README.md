####1 SBC-pin_NFT_IPFS

This is a .js file that retrieves the JSON URL of the NFT file from the PINATA site.

Try running some of the following tasks:

To install all dependancies, run the following command
```shell
yarn install
```

To compile the index.js, try this
```
yarn start
```

There is both a URL for the .png file stored as an NFT and a URL for the JSON file.
Copy the JSON URL from the command prompt and use it in the contract minting process.


####2 SBC NFT Evolution

This contract is for evolution of SBC NFTs. The blank pendant is filled with user's custom NFT by uploading metadata of the NFT.

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
yarn hardhat verify <deployed contract address> SBC SBC --network sepolia
```

