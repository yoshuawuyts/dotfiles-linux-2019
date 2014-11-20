{View} = require 'atom'

module.exports =
class GoFormatStatusView extends View
  @content: ->
    @div class: 'go-format-status inline-block'

  destroy: ->
    @detach()

  initialize: ->
    setTimeout((=> @attach()), 0)

  attach: ->
    statusbar = atom.workspaceView.statusBar
    statusbar.appendRight this
