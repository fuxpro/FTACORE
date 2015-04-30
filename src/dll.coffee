fs = require 'fs'

readCard = (cardName, callback) ->
  fs.readFile "#{__dirname}\\#{cardName}", (error, data) ->
    callback error, {} if error
    callback {"errorCode":"IDC88888", "errorDesc":"连接[NtCardReader]成功"}, JSON.parse(data)

NtCardReader = (track1, track2, track3, cardNo, callback) ->
  readCard "card.json", callback

NtCLCardReader = (track1, track2, track3, cardNo, callback) ->
  readCard "cl_card.json", callback

NtMagneticStripeReader = (track1, track2, track3, cardNo, callback) ->
  readCard "magnetic_stripe_card.json", callback

NtIdentityReader = (callback) ->
  readCard "identity_card.json", callback

readCardSync = (serviceName) ->
  content = fs.readFileSync "#{__dirname}\\#{serviceName}"
  if !content
    return  error: {"errorCode":"IDC00000", "errorDesc":"连接[NtCLCardReader]失败"}, data: {}

  return error: {"errorCode":"IDC88888", "errorDesc":"连接[NtCardReader]成功"}, data: JSON.parse(content)


NtCardReaderSync = (track1, track2, track3, cardNo) ->
  readCardSync "card.json"

NtCLCardReaderSync = (track1, track2, track3, cardNo, callback) ->
  readCardSync "cl_card.json"

NtMagneticStripeReaderSync = (track1, track2, track3, cardNo, callback) ->
  readCardSync "magnetic_stripe_card.json"

NtIdentityReaderSync = ->
  readCardSync "identity_card.json"


getReaderStatus = (readerName, callback) ->
  fs.readFile "#{__dirname}\\card_reader.json", (error, data) ->
    callback error, JSON.parse(data)

getNtCardReaderStatus = (callback) ->
  getReaderStatus "card_reader.json", callback

getNtCLCardReaderStatus = (callback) ->
  getReaderStatus "cl_card_reader.json", callback

getNtMagneticStripeReaderStatus = (callback) ->
  getReaderStatus "magnetic_stripe_card_reader.json", callback

getNtIdentityReaderStatus = (callback) ->
  getReaderStatus "identity_card_reader.json", callback


getReaderStatusSync = (readerName) ->
  content = fs.readFileSync "#{__dirname}\\#{readerName}"
  if not content
    return error: {"errorCode":"IDC88888", "errorDesc":"连接[NtCLCardReader]失败"}, data: {"status":"99"}
  return error: {"errorCode":"IDC88888", "errorDesc":"连接[NtCardReader]成功"}, data: JSON.parse(content)

getNtCardReaderStatusSync = () ->
  getReaderStatusSync "card_reader.json"


getNtCLCardReaderStatusSync = () ->
  getReaderStatusSync "cl_card_reader.json"


getNtMagneticStripeReaderStatusSync = () ->
  getReaderStatusSync "magnetic_stripe_card_reader.json"


getNtIdentityReaderStatusSync = () ->
  getReaderStatusSync "identity_card_reader.json"


operateCard = (serviceName, action, callback) ->
  callback {"errorCode":"IDC88888","errorDesc":"连接[NtCardReader]设备错误"}

operateCardSync = (serviceName, action) ->
  return {"errorCode":"IDC88888","errorDesc":"连接[NtCardReader]设备错误"}

printData = (serviceName, data, callback) ->
  callback {"errorCode":"PTR88888", "errorDesc":"连接[NtDocumentPrinter]设备错误"}

printDataSync = (serviceName, data) ->
  return {"errorCode":"PTR88888", "errorDesc":"连接[NtDocumentPrinter]设备错误"}

printDimensionCodeData = (serviceName, codeType, codeImgPath, callback) ->
  callback {"errorCode":"PTR88888", "errorDesc":"连接[NtDocumentPrinter]设备错误"}

printDimensionCodeDataSync = (serviceName, codeType, codeImgPath) ->
  return {"errorCode":"PTR88888", "errorDesc":"连接[NtDocumentPrinter]设备错误"}

getPrinterStatus = (serviceName, callback) ->
  callback {"errorCode":"PTR88888", "errorDesc":"连接[NtDocumentPrinter]设备错误"}, {"status":"00"}

getPrinterStatusSync = (serviceName) ->
  return {"error":{"errorCode":"PTR88888", "errorDesc":"连接[NtDocumentPrinter]设备错误"}, "status":{"status":"00"}}

operatePrinter = (serviceName, action, callback) ->
  callback {"errorCode":"PTR88888", "errorDesc":"连接[NtDocumentPrinter]设备错误"}

operatePrinterSync = (serviceName, action) ->
  return {"errorCode":"PTR88888", "errorDesc":"连接[NtDocumentPrinter]设备错误"}

module.exports =
  NtCardReader                       : NtCardReader
  NtCLCardReader                     : NtCLCardReader
  NtMagneticStripeReader             : NtMagneticStripeReader
  NtIdentityReader                   : NtIdentityReader
  NtCardReaderSync                   : NtCardReaderSync
  NtCLCardReaderSync                 : NtCLCardReaderSync
  NtMagneticStripeReaderSync         : NtMagneticStripeReaderSync
  NtIdentityReaderSync               : NtIdentityReaderSync
  getNtCardReaderStatus              : getNtCardReaderStatus
  getNtCLCardReaderStatus            : getNtCLCardReaderStatus
  getNtMagneticStripeReaderStatus    : getNtMagneticStripeReaderStatus
  getNtIdentityReaderStatus          : getNtIdentityReaderStatus
  getNtCardReaderStatusSync          : getNtCardReaderStatusSync
  getNtCLCardReaderStatusSync        : getNtCLCardReaderStatusSync
  getNtMagneticStripeReaderStatusSync: getNtMagneticStripeReaderStatusSync
  getNtIdentityReaderStatusSync      : getNtIdentityReaderStatusSync
  operateCard                        : operateCard
  operateCardSync                    : operateCardSync
  printData                          : printData
  printDataSync                      : printDataSync
  printDimensionCodeData             : printDimensionCodeData
  printDimensionCodeDataSync         : printDimensionCodeDataSync
  getPrinterStatus                   : getPrinterStatus
  getPrinterStatusSync               : getPrinterStatusSync
  operatePrinter                     : operatePrinter
  operatePrinterSync                 : operatePrinterSync