const Stablecoin      = artifacts.require('Stablecoin')

module.exports = async function(deployer, _network) {

  console.log(`Deployed on network:  ${_network} by Address: ${deployer}`)
  await deployer.deploy(Stablecoin)

};