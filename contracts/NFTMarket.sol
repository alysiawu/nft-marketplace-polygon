// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
// security control ReentrancyGuard, used when talking to a diff contract
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "hardhat/console.sol";

contract NFTMarket is ReentrancyGuard {
  using Counters for Counters.Counter;
  // Solidity Array 
  Counters.Counter private _itemIds;
  Counters.Counter private _itemsSold;

  address payable owner;
  // listing fee
  // gwei, wei 0.025000000
  // deploying to mantic 18 decimal points 
  uint256 listingPrice = 0.025 ether;

  constructor() {
    owner = payable(msg.sender);
  }

  struct MarketItem {
    uint itemId;
    address nftContract;
    uint256 tokenId;
    address payable seller;
    address payable owner;
    uint256 price;
    bool sold;
  }

  mapping(uint256 => MarketItem) private idToMarketItem;

  event MarketItemCreated (
    uint indexed itemId,
    address indexed nftContract,
    uint256 indexed tokenId,
    address seller,
    address owner,
    uint256 price,
    bool sold
  );

   /* Returns the listing price of the contract */
  function getListingPrice() public view returns (uint256) {
    return listingPrice;
  }


  function createMarketItem(
    address nftContract,
    uint256 tokenId,
    uint256 price
  ) public payable nonReentrant { 
    // nonReentrant is a modifier 
    require(price > 0, "Price must be at least 1 wei");
    // require(msg.value == _listingPrice, "Price must be equal to listin price");

    _itemIds.increment();

    uint256 itemId = _itemIds.current();
    idToMarketItem[itemId] =  MarketItem(
      itemId,
      nftContract,
      tokenId,
      payable(msg.sender),
      // empty address
      payable(address(0)), 
      price,
      false
    );

    IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);

    emit MarketItemCreated(
      itemId,
      nftContract,
      tokenId,
      msg.sender,
      address(0),
      price,
      false
    );
  }


  /* Creates the sale of a marketplace item */
  /* Transfers ownership of the item, as well as funds between parties */
  function createMarketSale(
    address nftContract,
    uint256 itemId
    ) public payable nonReentrant {
      // uint price = idToMarketItem[itemId].price;
      uint tokenId = idToMarketItem[itemId].tokenId;
      // console.log('==msg', msg);
      // require(msg.value == price, "Please submit the asking price in order to complete the purchase");
      idToMarketItem[itemId].seller.transfer(msg.value);
      IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
      //  IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
      idToMarketItem[itemId].owner = payable(msg.sender);
      idToMarketItem[itemId].sold = true;
      _itemsSold.increment();
      payable(owner).transfer(listingPrice);
  }

  /* Returns all unsold market items */
  function fetchMarketItems() public view returns (MarketItem[] memory) {
    uint itemCount = _itemIds.current();
    uint unsoldItemCount = _itemIds.current() - _itemsSold.current();
    uint currentIndex = 0;
    // memory
    MarketItem[] memory items = new MarketItem[](unsoldItemCount);
    for (uint i = 0; i < itemCount; i++) {
      // check if this item is unsold, address[0] is empty address
      if (idToMarketItem[i + 1].owner == address(0)) {
        uint currentId = i + 1;
        // storage 
        MarketItem storage currentItem = idToMarketItem[currentId];
        // insert that item to the array
        items[currentIndex] = currentItem;
        currentIndex += 1;
      }
    }
    return items;
  }

  /* Returns onlyl items that a user has purchased */
  function fetchMyNFTs() public view returns (MarketItem[] memory) {
    uint totalItemCount = _itemIds.current();
    uint itemCount = 0;
    uint currentIndex = 0;

    for (uint i = 0; i < totalItemCount; i++) {
      if (idToMarketItem[i + 1].owner == msg.sender) {
        itemCount += 1;
      }
    }

    MarketItem[] memory items = new MarketItem[](itemCount);
    for (uint i = 0; i < totalItemCount; i++) {
      if (idToMarketItem[i + 1].owner == msg.sender) {
        uint currentId = i + 1;
        MarketItem storage currentItem = idToMarketItem[currentId];
        items[currentIndex] = currentItem;
        currentIndex += 1;
      }
    }
    return items;
  }

  /* Returns only items a user has created */
  function fetchItemsCreated() public view returns (MarketItem[] memory) {
    uint totalItemCount = _itemIds.current();
    uint itemCount = 0;
    uint currentIndex = 0;

    for (uint i = 0; i < totalItemCount; i++) {
      if (idToMarketItem[i + 1].seller == msg.sender) {
        itemCount += 1;
      }
    }

    MarketItem[] memory items = new MarketItem[](itemCount);
    for (uint i = 0; i < totalItemCount; i++) {
      if (idToMarketItem[i + 1].seller == msg.sender) {
        uint currentId = i + 1;
        MarketItem storage currentItem = idToMarketItem[currentId];
        items[currentIndex] = currentItem;
        currentIndex += 1;
      }
    }
    // helper2(totalItemCount, items, currentIndex);
    return items;
  }


  // function helper(uint256 totalItemCount, MarketItem[] storage items, uint256 currentIndex) private {
  //   for (uint i = 0; i < totalItemCount; i++) {
  //     if (idToMarketItem[i + 1].owner == msg.sender) {
  //       uint currentId = i + 1;
  //       MarketItem storage currentItem = idToMarketItem[currentId];
  //       items[currentIndex] = currentItem;
  //       currentIndex += 1;
  //     }
  //   }
  // }

  // function helper2(uint256 totalItemCount, MarketItem[] memory items, uint256 currentIndex) private {
  //   for (uint i = 0; i < totalItemCount; i++) {
  //     if (idToMarketItem[i + 1].owner == msg.sender) {
  //       uint currentId = i + 1;
  //       MarketItem storage currentItem = idToMarketItem[currentId];
  //       items[currentIndex] = currentItem;
  //       currentIndex += 1;
  //     }
  //   }
  // }

}