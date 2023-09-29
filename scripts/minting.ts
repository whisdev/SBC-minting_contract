import { ethers } from "hardhat";

async function main() {

  const collectionName = "SBC";
  const collectionSymbol = "sbc";
  const collectionAdd1 = "0x18Ed8e3De1eae49438fe9bceE570982c98aB09e0";
  const collectionAdd2 = "0x7F0eF5632d91A26cD7B67FB2b3aDCEdDFb5868D7";

  const DigiMonkzStaking = await ethers.getContractFactory("DigiMonkzStaking");
  const digiMonkzStaking = await DigiMonkzStaking.deploy(collectionName, collectionSymbol, collectionAdd1, collectionAdd2);

  await digiMonkzStaking.deployed();

  console.log("Contract deployed to address: ", digiMonkzStaking.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
