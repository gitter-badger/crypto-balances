Promise = require("bluebird")
services = require('./services')
checker = require('./address-checker')

balance = (addr, callback) ->
  Promise
    .settle((fn(addr) if checker[s.toString()](addr)) for s, fn of services)
    .timeout(10000)
    .cancellable()
    .map (pi) -> pi.isFulfilled() and pi.value()
    .filter (item) -> !!item
    .reduce (a, b) ->
      a.concat b
    , []
    .filter (asset) ->
      !asset.address or asset.address == addr
    .nodeify callback

module.exports = balance
