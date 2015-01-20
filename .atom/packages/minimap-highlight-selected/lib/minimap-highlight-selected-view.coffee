{View} = require 'atom'

module.exports = ->
  highlightSelectedPackage = atom.packages.getLoadedPackage('highlight-selected')

  highlightSelected = require (highlightSelectedPackage.path)
  HighlightedAreaView = require (highlightSelectedPackage.path + '/lib/highlighted-area-view')

  class FakeEditor
    constructor: (@minimap) ->

    getActiveMinimap: -> @minimap.getActiveMinimap()

    getActiveTextEditor: -> @getActiveMinimap()?.getTextEditor()

    ['markBufferRange', 'scanInBufferRange', 'getEofBufferPosition', 'getSelections', 'getLastSelection', 'bufferRangeForBufferRow', 'getTextInBufferRange'].forEach (key) ->
      FakeEditor::[key] = -> @getActiveTextEditor()[key](arguments...)

    ['decorateMarker'].forEach (key) ->
      FakeEditor::[key] = -> @getActiveMinimap()[key](arguments...)

  class MinimapHighlightSelectedView extends HighlightedAreaView
    constructor: (minimap) ->
      super
      @fakeEditor = new FakeEditor(minimap)

    getActiveEditor: -> @fakeEditor

    handleSelection: ->
      return unless atom.workspace.getActiveTextEditor()?
      super
