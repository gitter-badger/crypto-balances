# Crypto-balance

[![Join the chat at https://gitter.im/ValeryLitvin/crypto-balances](https://badges.gitter.im/ValeryLitvin/crypto-balances.svg)](https://gitter.im/ValeryLitvin/crypto-balances?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Easy check addresses balances of various crypto tokens. Script automaticaly recognize a protocol by address and return balance of tokens associated with it.

On repo project folder type:
```
~ » npm run balance 0xfc30a6c6d1d61f0027556ed25a670345ab39d0cb

  { status: 'success',
  service: 'http://api.etherscan.io',
  address: '0xfc30a6c6d1d61f0027556ed25a670345ab39d0cb',
  quantity: '790000000000000000',
  system: 'Ethereum' }

  0.79000000000 ethers
```

## Node.js

```
var balance = require('crypto-balances');
balance("0xfc30a6c6d1d61f0027556ed25a670345ab39d0cb", function(error, result) {
  console.log(result);
});

[{"quantity":"0.79","asset":"ETH"}]
```

## Supported Protocols

- Using `https://chain.so`: Bitcoin, Litecoin, Dogecoin
- Using `http://etherscan.io`: Ethereum
- Using `http://blockscan.com`: Counterparty
- Using `https://chainz.cryptoid.info`: Dash, PeerCoin, Blackcoin, Grantcoin, CapriCoin, Rubycoin
- Using `https://api.coinprism.com`: Open Assets Protocol
- Using `https://api.ripple.com`: Ripple and Ripple based IOUs
- Using `http://jnxt.org`: NXT and NXT AE (on port 7876)
- Using `http://node.cyber.fund`: NEM (on port 7890)

## Installation

```
~ » git clone https://github.com/ValeryLitvin/crypto-balances
~ » cd crypto-balances
~ » make init
~ » make build
```

## Tests
```
~ » npm test
```

## Next Milestone
- Add BitShares
- Add other cyber•rated systems
- Update dependencies and refactoring

## License

Under MIT License
