{SelectListView, $} = require 'atom-space-pen-views'

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
    workspaceElement = atom.views.getView(atom.workspace)
    $(workspaceElement).append(@element)
    @focusFilterEditor()

  cancel: ->
    $(@element).remove();


# class MySelectListView extends SelectListView
