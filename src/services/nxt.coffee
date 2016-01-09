Promise = require("bluebird")
req = Promise.promisify(require("request"))
_ = require("lodash")
InvalidResponseError = require("../errors").InvalidResponseError
converter = require("./../converter")

nxt = (addr) ->
  url = "http://jnxt.org:7876/nxt?requestType=getBalance&account=#{addr}"

  req(url, json: true)
    .timeout(2000)
    .cancellable()
    .spread (resp, json) ->
      if resp.statusCode in [200..299]
        status: "success"
        service: url
        address: addr
        asset: "NXT"
        quantity: converter.toCoin(json.guaranteedBalanceNQT, "NQT")
      else
        if _.isObject(json) and json.message == "error"
          []
        else
          throw new InvalidResponseError service: url, response: resp

    .catch Promise.TimeoutError, (e) ->
      [status: 'error', service: url, message: e.message, raw: e]
    .catch InvalidResponseError, (e) ->
      [status: "error", service: e.service, message: e.message, raw: e.response]

module.exports = nxt
