bs58check = require('bs58check')

module.exports =
  chainso: (addr) ->
    chainso = RegExp('^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$').test(addr) ||
      RegExp('^[LD][a-km-zA-HJ-NP-Z1-9]{33}$').test(addr)
    if chainso
      return true
    else false

  # Every Counterparty address is also a Bitcoin address
  # Example 16WhhnUUCZVvszFxsaCG3d6v77Qin1LErQ
  counterparty: (addr) ->
    RegExp('^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$').test(addr)

 # Ethereum account address starts with 0x
 # Example 0xde0b295669a9fd93d5f28d9ec85e40f4cb697bae
  ethereum: (addr) ->
    RegExp('^(0x)?[0-9a-f]{40}$').test(addr)

  # Short name for sending funds to an account, rXXXX
  # Example r9kiSEUEw6iSCNksDVKf9k3AyxjW3r1qPf
  ripple: (addr) ->
    RegExp('^r[1-9A-HJ-NP-Za-km-z]{25,33}$').test(addr)

  # Addresses are always prefixed with "NXT-",
  # and hyphens are used to separate the address
  # into groups of 4, 4, 4, and then 5 characters.
  # Example NXT-8MVA-XCVR-3JC9-2C7C3
  nxt: (addr) ->
    RegExp('^(NXT|nxt)(-[a-zA-Z0-9]{4,5}){4}$').test(addr)

  # Example NXT-8N9W-TN4F-YA2S-H5B7R
  nxtassets: (addr) ->
    RegExp('^(NXT|nxt)(-[a-zA-Z0-9]{4,5}){4}$').test(addr)

  # Main network whose account addresses always start with a capital N.
  # Addresses have always a length of 40 characters and are base-32 encoded.
  # Example NCXIP5-JNP4GC-3JXXBB-U2UHF4-F4JYJ4-4DWFMN-EIMQ
  nem: (addr) ->
    RegExp('^[nN][a-zA-Z0-9]{5}(-[a-zA-Z0-9]{4,6}){6}$').test(addr)

  # Using cryptoid for altcoins (Dash, Blackcoin, Peercoin)
  # address length is 34
  # Example for Peercoin is PGVtF7DJ4KtndgdYZ472skrZQx3MDHNymt
  cryptoid: (addr) ->
    RegExp('^[CGRXPB][a-km-zA-HJ-NP-Z1-9]{33}$').test(addr)

  # The namespace used for Open Assets is 19 (0x13 in hexadecimal)
  # Example akB4NBW9UuCmHuepksob6yfZs6naHtRCPNy
  openassets: (addr) ->
    try decoded = bs58check.decode(addr)
    catch error
      return false
    decoded[0] == 19
