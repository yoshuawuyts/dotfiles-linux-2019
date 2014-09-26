{View} = require 'atom'

module.exports =

class JsfmtErrorView extends View

  # No errors until we specify one.
  initialize: -> @hide()

  # Essentially contains just one tool panel, with one message
  @content: ->
    @div click: 'hide', class: 'jsfmt', =>
      @div class: 'tool-panel panel-bottom padded', =>
        @span class: 'text-error', '⚠ '
        @span outlet: 'message', ''

  # Sets the error message
  setMessage: (msg) ->
    @message.text(msg)
    @show()
