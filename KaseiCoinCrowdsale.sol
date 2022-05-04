pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale { 
    
   
    constructor(
        uint rate, // rate in KaseiCoin
        address payable wallet, // beneficiary wallet
        KaseiCoin token // the token used by the token sale
    ) 

    Crowdsale(rate, wallet, token)
        public
        {

        }
}


contract KaseiCoinCrowdsaleDeployer {
    
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet 
    ) 
    public 
    {
       //Create the KaseiCoin token
        KaseiCoin Token = new KaseiCoin(name, symbol, 0);
        kasei_token_address = address(Token);

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        KaseiCoinCrowdsale kasei_sale = new KaseiCoinCrowdsale(1, wallet, Token);
            
        // Assign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        kasei_crowdsale_address = address(kasei_sale);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        Token.addMinter(kasei_crowdsale_address);
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        Token.renounceMinter();
    }
}
