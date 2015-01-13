{Range} = require 'atom'

module.exports =
    class Aligner

      # Public
      @alignFor: (editor) ->
        new Aligner(editor).lines()

      # Public
      constructor: (@editor) ->

      # Public
      lines: ->
        selectionRanges = @selectionRanges()
        if selectionRanges.length isnt 0
          selectionRanges.map (selectionRange) =>
            @sortableRangeFrom(selectionRange)

      # Internal
      selectionRanges: ->
        @editor.getSelectedBufferRanges().filter (range) ->
          not range.isEmpty()

      # Internal
      sortableRangeForEntireBuffer: ->
        @editor.getBuffer().getRange()

      # Internal
      sortableRangeFrom: (selectionRange) ->
        startRow = selectionRange.start.row
        startCol = 0
        endRow = if selectionRange.end.column == 0
          selectionRange.end.row - 1
        else
          selectionRange.end.row
        endCol = @editor.lineLengthForBufferRow(endRow)
        new Range [startRow, startCol], [endRow, endCol]
