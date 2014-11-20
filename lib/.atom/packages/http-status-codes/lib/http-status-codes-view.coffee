{$$, Point, SelectListView} = require 'atom'
# CSON.parseFile 'data.cson', (err,obj) ->
#   result = CSON.parseFileSync('data.cson')

statusCodes = require '../data/status-codes'

module.exports =
class HttpStatusCodesView extends SelectListView

  getFilterKey: -> 'title'

  initialize: (serializeState) ->
    super
    @addClass('overlay from-top http-status-codes-view')

  viewForItem: (item) ->
    "<li><strong>#{item.code}</strong> #{item.message}</li>"

  confirmed: (item) ->
    atom.clipboard.write(item.title)
    @cancel()

  populate: ->
    statusCodes.forEach (item) -> item.title = "#{item.code} #{item.message}"
    @setItems(statusCodes)

  show: ->
    @populate()
    atom.workspaceView.append(this)
    @focusFilterEditor()

# class MySelectListView extends SelectListView
