HttpStatusCodesView = require './http-status-codes-view'

module.exports =

  activate: (state) ->

    httpStatusCodesView: null

    atom.commands.add 'atom-workspace',
      'http-status-codes:show', =>
        @httpStatusCodesView ?= new HttpStatusCodesView()
        @httpStatusCodesView.show()
