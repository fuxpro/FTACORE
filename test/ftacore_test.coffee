should = require 'should'
ftacore = require '../src/ftacore.coffee'


describe 'ftacore test', ->
  this.timeout 10000

  it 'fireEvent', (done) ->
    myevent =
      source  : 'A'
      fireTime: '2015'
      type    : 'insertCard'
    ftacore.fireEvent myevent
    done()

  it 'addListener', (done) ->
    event_string = 'insertPaper'
    ftacore.addListener event_string, (event) ->
      console.log "event is: ", event

    myevent =
      source  : 'A'
      fireTime: '2015'
      type    : 'insertCard'

    ftacore.fireEvent myevent
    done()

  it 'readCard:NtCardReader', (done) ->
    param =
      ver        : "1.1.1.1"
      timeOut    : 3000
      serviceName: "NtCardReader"
      readData   : ["track2", "track3", "cardNo"]

    ftacore.readCard param, (error, data) ->
      console.log "error: ", error
      console.log "data: ", data
      done()

  it 'readCard:NtIdentityReader', (done) ->
    param =
      serviceName: "NtIdentityReader"
      readData   : [
        'idName'
        'idGender'
        'idFolk'
        'idBirthDay'
        'idAddress'
        'idAgency'
        'idExpireStart'
        'idExpireEnd'
        'idPicture'
      ]

    ftacore.readCard param, (error, data) ->
      console.log "error: ", error
      console.log "data: ", data
      done()

  it 'readCardSync:NtCardReaderSync', (done) ->
    param =
      serviceName: "NtCardReader"
      readData   : ["track2", "track3", "cardNo"]

    console.log ftacore.readCardSync(param)
    done()

  it 'readCardSync:NtIdentityReaderSync', (done) ->
    param =
      serviceName: "NtIdentityReader"
      readData   : ["idGender"]

    console.log ftacore.readCardSync(param)
    done()

  it 'getCardReaderStatus:getNtCardReaderStatus', (done) ->
    param =
      serviceName: 'NtCardReader'

    ftacore.getCardReaderStatus param, (error, data) ->
      console.log "error: ", error
      console.log "data: ", data
      done()

  it 'getCardReaderStatus:getNtIdentityReaderStatus', (done) ->
    param =
      serviceName: 'NtCardReader'

    ftacore.getCardReaderStatus param, (error, data) ->
      console.log "error: ", error
      console.log "data: ", data
      done()

  it 'getCardReaderStatusSync:getNtCardReaderStatusSync', (done) ->
    param =
      serviceName: 'NtCardReader'

    console.log ftacore.getCardReaderStatusSync(param)
    done()

  it 'operateCard', (done) ->
    param =
      serviceName: 'NtCardReader'
      action: 'off'
    ftacore.operateCard param, (err) ->
      console.log err
      done()

  it 'operateCardSync', (done) ->
    param =
      serviceName: 'NtCardReader'
      action: 'off'
    console.log ftacore.operateCardSync(param)
    done()

  it 'printData', (done) ->
    param =
      serviceName: 'NtDocumentPrinter'
      data: []

    ftacore.printData param, (err) ->
      console.log err
      done()

  it 'printDataSync', (done) ->
    param =
      serviceName: 'NtDocumentPrinter'
      data: []

    console.log ftacore.printDataSync param
    done()

  it 'printDimensionCodeData', (done) ->
    param =
      serviceName: 'NtDocumentPrinter'
      codeType: 1
      codeImgPath: "QRcode.jpg"

    ftacore.printDimensionCodeData param, (err) ->
      console.log err
      done()

  it 'printDimensionCodeDataSync', (done) ->
    param =
      serviceName: 'NtDocumentPrinter'
      codeType: 1
      codeImgPath: "QRcode.jpg"

    console.log ftacore.printDimensionCodeDataSync(param)
    done()

  it 'getPrinterStatus', (done) ->
    param =
      serviceName: 'NtDocumentPrinter'

    ftacore.getPrinterStatus param, (err) ->
      console.log err
      done()

  it 'getPrinterStatusSync', (done) ->
    param =
      serviceName: 'NtDocumentPrinter'

    console.log ftacore.getPrinterStatusSync(param)
    done()

  it 'operateCard', (done) ->
    param =
      serviceName: "NtDocumentPrinter"
      action: 'eject'

    ftacore.operatePrinter param, (err) ->
      console.log  err
      done()

  it 'operatePrinterSync', (done) ->
    param =
      serviceName: "NtDocumentPrinter"
      action: 'eject'

    console.log ftacore.operatePrinterSync(param)
    done()

  it 'getImage', (done) ->
    location =
      host: 'www.baidu.com'
      port: 80
      path: '/img/bdlogo.png'

    ftacore.getImage location, (path) ->
      console.log path
      done()
