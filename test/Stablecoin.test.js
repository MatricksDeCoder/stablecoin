const Stablecoin  = artifacts.require('./Stablecoin')
const PriceConsumer = artifacts.require('./PriceConsumer')

require('chai')
  .use(require('chai-as-promised'))
  .should()

contract('Stablecoin', ([deployer, reporter, notReporter]) => {

    let result,txRes,stablecoin

    beforeEach( async () => {
        stablecoin = await Stablecoin.new()
    })

    describe('adjustSupply()', () => {

    })

    describe('deployment', () => {

    })

    describe('borrowPosition()', () => {

    })

    describe('redeemPosition()', () => {

    })

    describe('liquidatePosition()', () => {

    })


})