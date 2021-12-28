// const { expect } = require("chai");
// const { ethers } = require("hardhat");

describe("NFTMarket", function () {
  it("Should create and execute market sales", async function () {
    const Market = await ethers.getContractFactory("NFTMarket");
    const market = await Market.deploy();
    await market.deployed();
    const marketAddress = market.address

    const NFT = await ethers.getContractFactory("NFT")
    const nft = await NFT.deploy(marketAddress)
    await nft.deployed()
    const nftContractAddress = nft.address

    let listingPrice = await market.getListingPrice()
    listingPrice = listingPrice.toString()
    console.log('==listingPrice', listingPrice)
    const auctionPrice = ethers.utils.parseUnits('100', 'ether')
    console.log('==auctionPrice', auctionPrice)
    await nft.createToken("https://www.mytokenlocation.com")
    await nft.createToken("https://www.mytokenlocation2.com")

    await market.createMarketItem(nftContractAddress, 1, auctionPrice)
    await market.createMarketItem(nftContractAddress, 2, auctionPrice)

    // await market.createMarketItem(nftContractAddress, 1, auctionPrice, listingPrice)
    // await market.createMarketItem(nftContractAddress, 2, auctionPrice, listingPrice)

    const [_, buyerAddress] = await ethers.getSigners()

    const contract = await market.connect(buyerAddress)
    console.log('==contract', contract)
    contract.createMarketSale(nftContractAddress, 1)

    let items = await market.fetchMarketItems()

    const helper = async (i) => {
      const tokenUri = await nft.tokenURI(i.tokenId)
      let _item = {
        price: i.price.toString(),
        tokenId: i.tokenId.toString(),
        seller: i.seller,
        owner: i.owner,
        tokenUri
      }
      console.log('_item: ', _item)
      return _item
    }
    console.log('==items.map(helper)', items.map(helper))
    
    const test = await Promise.all(items.map(helper))
    console.log('test: ', test)
  });
});
