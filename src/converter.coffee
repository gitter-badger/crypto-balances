Big = require('big.js')

conversion = {
  "ETH": 1000000000000000000,
  "NQT": 100000000
}

module.exports =
  toCoin: (basicAmount, type) ->
    if (typeof basicAmount == 'string')
      basicAmount = Number(basicAmount)
    bigBasicAmount = new Big(basicAmount)
    Number(bigBasicAmount.div(conversion[type])).toString()

  toSatoshi: (coin, type) ->
    if (typeof coin == 'string')
      coin = Number(coin)
    bigCoin = new Big(coin);
    Number(bigCoin.times(conversion[type])).toString()
