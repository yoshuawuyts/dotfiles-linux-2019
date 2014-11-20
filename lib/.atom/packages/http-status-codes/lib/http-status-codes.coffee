HttpStatusCodesView = require './http-status-codes-view'

module.exports =

  activate: (state) ->

    httpStatusCodesView: null

    atom.workspaceView.command 'http-status-codes:show', =>
      @httpStatusCodesView ?= new HttpStatusCodesView()
      @httpStatusCodesView.show()
