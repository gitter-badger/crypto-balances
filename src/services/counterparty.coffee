Promise = require("bluebird")
req = Promise.promisify(require("request"))
_ = require("lodash")
InvalidResponseError = require("../errors").InvalidResponseError

counterparty = (addr) ->
  url = "http://xcp.blockscan.com/api2?module=address&action=balance&btc_address=#{addr}"

  req(url, json: true)
    .timeout(3000)
    .cancellable()
    .spread (resp, json) ->
      if resp.statusCode in [200..299] and _.isArray(json.data)
        json.data
      else
        if _.isObject(json) and json.message == "error"
          []
        else
          throw new InvalidResponseError service: url, response: resp
    .map (data) ->
      status: "success"
      service: url
      address: addr
      quantity: data.balance
      asset: data.asset

    .catch Promise.TimeoutError, (e) ->
      [status: 'error', service: url, message: e.message, raw: e]
    .catch InvalidResponseError, (e) ->
      [status: "error", service: e.service, message: e.message, raw: e.response]

module.exports = counterparty
