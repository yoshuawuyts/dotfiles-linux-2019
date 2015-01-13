{View, $} = require 'space-pen'

module.exports =
class TextEditorView extends View
  # The constructor for setting up an `TextEditorView` instance.
  constructor: (params={}) ->
    {mini, placeholderText, attributes} = params
    attributes ?= {}
    attributes['mini'] = mini if mini?
    attributes['placeholder-text'] = placeholderText if placeholderText?

    @element = document.createElement('atom-text-editor')
    @element.setAttribute(name, value) for name, value of attributes
    @element.__spacePenView = this if @element.__spacePenView?

    super

    @setModel(@element.getModel())

  setModel: (@model) ->

  # Public: Get the underlying editor model for this view.
  #
  # Returns a `TextEditor`
  getModel: -> @model

  # Public: Get the text of the editor.
  #
  # Returns a `String`.
  getText: ->
    @model.getText()

  # Public: Set the text of the editor as a `String`.
  setText: (text) ->
    @model.setText(text)

  # Public: Determine whether the editor is or contains the active element.
  #
  # Returns a `Boolean`.
  hasFocus: ->
    @element.hasFocus()
