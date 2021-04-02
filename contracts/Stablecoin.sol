// SPDX-License-Identifier: MIT

/*

Using Chainlink Oracle on Kovan Network
To get latest price
(
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

*/

pragma solidity ^0.7.3;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract Stablecoin {

    AggregatorV3Interface internal priceFeed;

    address public priceFeed;

    address public oracle;
    uint public targetPrice = 10 ** 18; //1 token = 10 ** 18 = 1 USD
    uint public initialSupply = 1000000 * 10 * 18; //100,000 tokens
    uint public treasury = 10000; //10,000 tokens

    uint totalSupply;// keep track totalSupply

    struct Position {
        uint collateral;
        uint token;
    }

    mapping(address => Position) public positions;
    uint public collatFactor = 150;  

    event Mint(uint _price, uint _targetPrice, uint _mintSupply, uint time);
    event Burn(uint _price, uint _tagetPrice, uint _burnSupply, uint time);

    /**
     * Network: Kovan
     * Aggregator: ETH/USD
     * Address: 0x9326BFA02ADD2366b30bacB125260Af641031331
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        _mint(msg.sender, initialSupply);
        totalSupply += initialSupply;
    }

    function adjustSupply(uint _price) {
        require(msg.sender == priceFeed, 'only price from oracle');
        if(_price > targetPrice)  { // create new tokens to increase supply 
            // (totalSupply+mintSupply)/totalSupply = price/targetPrice
            uint mintSupply = (price/targetPrice)*totalSupply - totalSupply;
            _mint(address(this), mintSupply);
            emit Mint(_price, targetPrice, mintSupply, block.timestamp);
        } else { // burn tokens to decrese supply 
            // (totalSupply -burnSupply)/totalSupply = targetPrice/price
            uint burnSupply = totalSupply - (targetPrice/price)*totalSupply;
            _burn(adddress(this), burnSupply);
            emit Burn(_price, targetPrice, burnSupply, block.timestamp);
        }
    }

}
