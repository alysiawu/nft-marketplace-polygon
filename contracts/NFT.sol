// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;
// https://docs.openzeppelin.com/contracts/3.x/api/token/erc721
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// setTokenURI
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// utils
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";

// inhereting from ERCStorage which inherets from ERC721
contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;

    // counters to increment tokenIds
    Counters.Counter private _tokenIds;
    // NFT to interact with 
    address contractAddress;

    constructor(address marketplaceAddress) ERC721("Metaverse", "METT") {
        contractAddress = marketplaceAddress;
    }

    function createToken(string memory tokenURI) public returns (uint) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        
        // made available from ERC-721 Storage 
        _setTokenURI(newItemId, tokenURI);
        // give marketplace approval to trasact 
        setApprovalForAll(contractAddress, true);
        // client application will need it
        return newItemId;
    }
}

