// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";


contract VotingNFTClaim is ERC721Enumerable, Ownable {
    /**
      * @dev _baseTokenURI for computing {tokenURI}. If set, the resulting URI for each
      * token will be the concatenation of the `baseURI` and the `tokenId`.
      */
    string _baseTokenURI;

    //  _price is the price of one Crypto Dev NFT
    uint256 public _price = 0.01 ether;

    // _paused is used to pause the contract in case of an emergency
    bool public _paused;


    // max number of CryptoDevs
    uint256 public maxTokenIds;

    // total number of tokenIds minted
    uint256 public tokenIds;


        // Max number of voting allowed
    uint16 public maxVoters;

    // Create a mapping of voters
    // if an address is whitelisted, we would set it to true, it is false by default for all other addresses.
    mapping(address => bool) public votingAddresses;
    

    // numAddressesWhitelisted would be used to keep track of how many addresses have been whitelisted
    // NOTE: Don't change this variable name, as it will be part of verification
    uint16 public numVoters;





    modifier onlyWhenNotPaused {
        require(!_paused, "Contract currently paused");
        _;
    }

    /**
      * @dev ERC721 constructor takes in a `name` and a `symbol` to the token collection.
      * name in our case is `Crypto Devs` and symbol is `CD`.
      * Constructor for Crypto Devs takes in the baseURI to set _baseTokenURI for the collection.
      * It also initializes an instance of whitelist interface.
      */
    constructor (uint16 _maxVoters) ERC721("Voters Choice", "VC") {
        maxVoters =  _maxVoters;
        maxTokenIds = _maxVoters;
    }

        /**
        addAddressToWhitelist - This function adds the address of the sender to the
        whitelist
     */
    function addAddressToVoters() public payable onlyWhenNotPaused() {
        // check if the user has already been whitelisted
        require(!votingAddresses[msg.sender], "Sender is already on the voter registry");
        // check if the numAddressesWhitelisted < maxWhitelistedAddresses, if not then throw an error.
        require(numVoters < maxVoters, "More addresses cant be added, limit reached");
        require(msg.value >= _price, "Ether sent is not correct");
        // Add the address which called the function to the whitelistedAddress array
        votingAddresses[msg.sender] = true;
        // Increase the number of whitelisted addresses
        numVoters+= 1;
        tokenIds += 1;
        //_safeMint is a safer version of the _mint function as it ensures that
        // if the address being minted to is a contract, then it knows how to deal with ERC721 tokens
        // If the address being minted to is not a contract, it works the same way as _mint
        _safeMint(msg.sender, tokenIds);
    }



    /**
    * @dev setPaused makes the contract paused or unpaused
      */
    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    /**
    * @dev withdraw sends all the ether in the contract
    * to the owner of the contract
      */
    function withdraw() public onlyOwner  {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

      // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}