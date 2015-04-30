events = require 'events'
dll = require './dll.coffee'

EVENT_TYPE = [
  'insertCard'
  'dropCard'
  'retainCard'
  'insertPaper'
  'takePaper'
  'retainPaper'
]

SERVICE_NAME = [
  'NtMagneticStripeReader'
  'NtCardReader'
  'NtCLCardReader'
  'NtIdentityReader'
]

CARD_ACTION = [
  "reset"
  "cancelRead"
  "off"
  "close"
]

PRINTER = [
  'NtDocumentPrinter'
  'NtReceiptPrinter'
]

PRINTER_ACTION = [
  'cancelPrint'
  'eject'
  'retain'
  'reset'
  'close'
]

class Event
  constructor: (_source, _fireTime, _type) ->
    @source   = _source
    @fireTime = _fireTime
    @type     = _type

class Actor extends events.EventEmitter
  constructor: () ->


actor = new Actor()


fireEvent = (event) ->
  if not event.type or event.type not in EVENT_TYPE
    return throw new Error('Event value error');
  else
    actor.emit event.type, event


addListener = (eventType, lisenter) ->
  if eventType not in EVENT_TYPE
    throw new Error('Unkown event value');
  actor.on eventType, lisenter


readCard = (param, callback) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in SERVICE_NAME
    throw new Error('Service name error')
  serviceName = param.serviceName

  if not param.readData or param.readData.length is 0
    throw new Error('Request data error')
  readData = param.readData

  track1 = 'track1'
  track2 = 'track2'
  track3 = 'track3'
  cardNo = 'cardNo'

  switch serviceName
    when 'NtCardReader'
      dll.NtCardReader track1, track2, track3, cardNo, (error, data) ->
        callback error, operateData(ver, serviceName, readData, data)

    when 'NtCLCardReader'
      dll.NtCLCardReader track1, track2, track3, cardNo, (error, data) ->
        callback error, operateData(ver, serviceName, readData, data)

    when 'NtMagneticStripeReader'
      dll.NtMagneticStripeReader track1, track2, track3, cardNo, (error, data) -> 
        callback error, operateData(ver, serviceName, readData, data)

    when 'NtIdentityReader'
      dll.NtIdentityReader (error, data) ->
        data.ver = ver
        data.serviceName = serviceName

        callback error, data

    else
      throw new Error('Unkown serviceName')

  operateData = (ver, serviceName, readData, data) ->
    result = {}
    result.ver = ver
    result.serviceName = serviceName
    for key in readData
      result[key] = data[key]
    return result


readCardSync = (param) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in SERVICE_NAME
    throw new Error('Service name error')
  serviceName = param.serviceName

  if not param.readData or param.readData.length is 0
    throw new Error('Request data error')
  readData = param.readData

  track1 = 'track1'
  track2 = 'track2'
  track3 = 'track3'
  cardNo = 'cardNo'

  operateDataSync = (ver, serviceName, readData, data) ->
    data.data.ver = ver
    data.data.serviceName = serviceName
    for key, value of data.data
      if key not in readData
        delete data.data[key]
    return data

  switch serviceName
    when 'NtCardReader'
      return operateDataSync ver, serviceName, readData, dll.NtCardReaderSync(track1, track2, track3, cardNo)

    when 'NtCLCardReader'
      return operateDataSync ver, serviceName, readData, dll.NtCLCardReaderSync(track1, track2, track3, cardNo)

    when 'NtMagneticStripeReader'
      return operateDataSync ver, serviceName, readData, dll.NtMagneticStripeReaderSync(track1, track2, track3, cardNo)

    when 'NtIdentityReader'
      return operateDataSync ver, serviceName, readData, dll.NtIdentityReaderSync()

    else
      throw new Error('Unkown serviceName')


getCardReaderStatus = (param, callback) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in SERVICE_NAME
    throw new Error('Service name error')
  serviceName = param.serviceName

  insertVerInfo = (readerStatus) ->
    readerStatus.ver = ver
    readerStatus.serviceName = serviceName
    return readerStatus

  switch serviceName
    when 'NtCardReader'
      dll.getNtCardReaderStatus (error, status) ->
        if error
          callback {"errorCode":"IDC88888", "errorDesc":"连接[NtCardReader]设备错误"}, {"status":"99"}
        callback {"errorCode":"IDC00000", "errorDesc":"连接[NtCardReader]设备成功"}, insertVerInfo(status)

    when 'NtCLCardReader'
      dll.getNtCLCardReaderStatus (error, status) ->
        if error
          callback {"errorCode":"IDC88888", "errorDesc":"连接[NtCardReader]设备错误"}, {"status":"99"}
        callback {"errorCode":"IDC00000", "errorDesc":"连接[NtCardReader]设备成功"}, insertVerInfo(status)

    when 'NtMagneticStripeReader'
      dll.getNtMagneticStripeReaderStatus (error, status) ->
        if error
          callback {"errorCode":"IDC88888", "errorDesc":"连接[NtCardReader]设备错误"}, {"status":"99"}
        callback {"errorCode":"IDC00000", "errorDesc":"连接[NtCardReader]设备成功"}, insertVerInfo(status)

    when 'NtIdentityReader'
      dll.getNtIdentityReaderStatus (error, status) ->
        if error
          callback {"errorCode":"IDC88888", "errorDesc":"连接[NtCardReader]设备错误"}, {"status":"99"}
        callback {"errorCode":"IDC00000", "errorDesc":"连接[NtCardReader]设备成功"}, insertVerInfo(status)

    else
      throw new Error("Service name error")


getCardReaderStatusSync = (param) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in SERVICE_NAME
    throw new Error('Service name error')
  serviceName = param.serviceName

  operateDataSync = (ver, serviceName, status) ->
    status.data.ver = ver
    status.data.serviceName = serviceName
    return status

  switch serviceName
    when 'NtCardReader'
      return operateDataSync ver, serviceName, dll.getNtCardReaderStatusSync()

    when 'NtCLCardReader'
      return operateDataSync ver, serviceName, dll.getNtCLCardReaderStatusSync()

    when 'NtMagneticStripeReader'
      return operateDataSync ver, serviceName, dll.getNtMagneticStripeReaderStatusSync()

    when 'NtIdentityReader'
      return operateDataSync ver, serviceName, dll.getNtIdentityReaderStatusSync()

    else
      throw new Error('Unkown serviceName')


operateCard = (param, callback) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in SERVICE_NAME
    throw new Error('Service name error')
  serviceName = param.serviceName
  if not param.action or param.action not in CARD_ACTION
    throw new Error('Unkown action')
  action = param.action

  dll.operateCard serviceName, action, callback

operateCardSync = (param) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in SERVICE_NAME
    throw new Error('Service name error')
  serviceName = param.serviceName
  if not param.action or param.action not in CARD_ACTION
    throw new Error('Unkown action')
  action = param.action

  dll.operateCardSync serviceName, action

printData = (param, callback) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in PRINTER
    throw new Error('Unkown printer type')
  serviceName = param.serviceName

  dll.printData serviceName, param.data, callback


printDataSync = (param) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in PRINTER
    throw new Error('Unkown printer type')
  serviceName = param.serviceName

  dll.printDataSync serviceName, param.data


printDimensionCodeData = (param,callback) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in PRINTER
    throw new Error('Unkown printer type')
  serviceName = param.serviceName

  dll.printDimensionCodeData serviceName, param.codeType, param.codeImgPath, callback


printDimensionCodeDataSync = (param) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in PRINTER
    throw new Error('Unkown printer type')
  serviceName = param.serviceName

  dll.printDimensionCodeDataSync serviceName, param.codeType, param.codeImgPath

getPrinterStatus = (param, callback) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in PRINTER
    throw new Error('Unkown printer type')
  serviceName = param.serviceName

  dll.getPrinterStatus serviceName, callback


getPrinterStatusSync = (param, callback) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in PRINTER
    throw new Error('Unkown printer type')
  serviceName = param.serviceName

  dll.getPrinterStatusSync serviceName

operatePrinter = (param,callback) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in PRINTER
    throw new Error('Unkown printer type')
  serviceName = param.serviceName

  if not param.action or param.action not in PRINTER_ACTION
    throw new Error('Unkown printer action')
  action = param.action

  dll.operatePrinter serviceName, action, callback

operatePrinterSync = (param) ->
  ver = param.ver || '1.0.0.0'
  timeOut = param.timeOut || 1000

  if not param.serviceName or param.serviceName not in PRINTER
    throw new Error('Unkown printer type')
  serviceName = param.serviceName

  if not param.action or param.action not in PRINTER_ACTION
    throw new Error('Unkown printer action')
  action = param.action

  return dll.operatePrinterSync serviceName, action



module.exports =
  fireEvent                 : fireEvent
  addListener               : addListener
  readCard                  : readCard
  readCardSync              : readCardSync
  getCardReaderStatus       : getCardReaderStatus
  getCardReaderStatusSync   : getCardReaderStatusSync
  operateCard               : operateCard
  operateCardSync           : operateCardSync
  printData                 : printData
  printDataSync             : printDataSync
  printDimensionCodeData    : printDimensionCodeData
  printDimensionCodeDataSync: printDimensionCodeDataSync
  getPrinterStatus          : getPrinterStatus
  getPrinterStatusSync      : getPrinterStatusSync
  operatePrinter            : operatePrinter
  operatePrinterSync        : operatePrinterSync