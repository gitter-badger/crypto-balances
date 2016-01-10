Promise = require("bluebird")
req = Promise.promisify(require("request"))
_ = require("lodash")
InvalidResponseError = require("../errors").InvalidResponseError

oa = (addr) ->
  url = "https://api.coinprism.com/v1/addresses/#{addr}"

  req(url, json: true)
    .timeout(5000)
    .cancellable()
    .spread (resp, json) ->
      if resp.statusCode in [200..299] and json.address == addr and _.isArray(json.assets)
        json.assets
      else
        if _.isObject(json) and json.Message == "Error" and json.ErrorCode == "InvalidAddress"
          []
        else
          throw new InvalidResponseError service: url, response: resp
    .map (asset) ->
      assetUrl = "https://api.coinprism.com/v1/assets/#{asset.id}"
      req(assetUrl, json: true)
        .timeout(10000)
        .cancellable()
        .spread (resp, json) ->
          if resp.statusCode in [200..299]
            if _.isNull json
              # fail gracefully when asset definition is unknown
              _.merge asset, symbol: "#{asset.id}", divisibility: 0
            else if json.asset_id == asset.id
              _.merge asset, symbol: "#{json.name_short.toUpperCase()}", divisibility: json.divisibility
          else
            throw new InvalidResponseError service: url, response: resp
    .map (asset) ->
      balance = parseInt(asset.balance, 10)
      quantity = balance / (10 ** asset.divisibility)

      status: "success"
      service: url
      address: addr
      quantity: quantity.toFixed(6)
      asset: asset.symbol

    .catch Promise.TimeoutError, (e) ->
      [status: 'error', service: url, message: e.message, raw: e]
    .catch InvalidResponseError, (e) ->
      [status: "error", service: e.service, message: e.message, raw: e.response]


module.exports = oa
