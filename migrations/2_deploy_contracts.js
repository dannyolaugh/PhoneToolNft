var SvgContract = artifacts.require("SvgContract");
var PhoneToolIcon = artifacts.require("PhoneToolIcon");

module.exports = async function(deployer) {
  await deployer.deploy(SvgContract);
  await deployer.deploy(PhoneToolIcon, SvgContract.address);
};
