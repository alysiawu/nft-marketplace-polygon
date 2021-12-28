### This is transaction looks like:

{
    "to": "0x5FbDB2315678afecb367f032d93F642f64180aa3",
    "from": "0x71bE63f3384f5fb98995898A86B02Fb2426c5788",
    "contractAddress": null,
    "transactionIndex": 0,
    "gasUsed": {
        "type": "BigNumber",
        "hex": "0x5858"
    },
    "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "blockHash": "0x8f14e6f7932daa6e15ea590fba58d86b328bd983c2cfe7e058d0d92c7e314cba",
    "transactionHash": "0xdb4ac13fd513d8b2152ae5b75395d2a022360e1f83ce511c6e2dce2800392948",
    "logs": [],
    "blockNumber": 5,
    "confirmations": 1,
    "cumulativeGasUsed": {
        "type": "BigNumber",
        "hex": "0x5858"
    },
    "effectiveGasPrice": {
        "type": "BigNumber",
        "hex": "0x5a33a991"
    },
    "status": 1,
    "type": 2,
    "byzantium": true,
    "events": []
}


### This is price looks like 
```

{
    "type": "BigNumber",
    "hex": "0x0de0b6b3a7640000"
}
```

### This is contract looks like 
  ```
  Contract {interface: Interface, provider: Web3Provider, signer: JsonRpcSigner, callStatic: {…}, estimateGas: {…}, …}
  address: "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"
  callStatic: {createMarketItem(address,uint256,uint256): ƒ, createMarketSale(address,uint256): ƒ, fetchItemsCreated(): ƒ, fetchMarketItems(): ƒ, fetchMyNFTs(): ƒ, …}
  createMarketItem: ƒ (...args)
  createMarketItem(address,uint256,uint256): ƒ (...args)
  createMarketSale: ƒ (...args)
  createMarketSale(address,uint256): ƒ (...args)
  estimateGas: {createMarketItem(address,uint256,uint256): ƒ, createMarketSale(address,uint256): ƒ, fetchItemsCreated(): ƒ, fetchMarketItems(): ƒ, fetchMyNFTs(): ƒ, …}
  fetchItemsCreated: ƒ (...args)
  fetchItemsCreated(): ƒ (...args)
  fetchMarketItems: ƒ (...args)
  fetchMarketItems(): ƒ (...args)
  fetchMyNFTs: ƒ (...args)
  fetchMyNFTs(): ƒ (...args)
  filters: {MarketItemCreated(uint256,address,uint256,address,address,uint256,bool): ƒ, MarketItemCreated: ƒ}
  functions: {createMarketItem(address,uint256,uint256): ƒ, createMarketSale(address,uint256): ƒ, fetchItemsCreated(): ƒ, fetchMarketItems(): ƒ, fetchMyNFTs(): ƒ, …}
  getListingPrice: ƒ (...args)
  getListingPrice(): ƒ (...args)
  interface: Interface {fragments: Array(8), _abiCoder: AbiCoder, functions: {…}, errors: {…}, events: {…}, …}
  populateTransaction: {createMarketItem(address,uint256,uint256): ƒ, createMarketSale(address,uint256): ƒ, fetchItemsCreated(): ƒ, fetchMarketItems(): ƒ, fetchMyNFTs(): ƒ, …}
  provider: Web3Provider {_isProvider: true, _events: Array(0), _emitted: {…}, formatter: Formatter, anyNetwork: false, …}
  resolvedAddress: Promise {<fulfilled>: '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'}
  signer: JsonRpcSigner {_isSigner: true, provider: Web3Provider, _index: 0, _address: null}
  _runningEvents: {}

  ```