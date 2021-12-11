const PereToken = artifacts.require("PereToken");
const CrowdSale = artifacts.require("CrowdSale");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(
    PereToken,
    "PereToken",
    "PRT",
    "10000000000000000000000"
  );
  const token = await PereToken.deployed();

  await deployer.deploy(CrowdSale, 1, accounts[0], token.address);
  const crowdsale = await CrowdSale.deployed();

  token.transfer(crowdsale.address, await token.totalSupply());
};
