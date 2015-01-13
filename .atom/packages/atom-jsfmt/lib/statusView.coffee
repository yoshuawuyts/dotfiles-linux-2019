{View} = require 'atom'

module.exports =

class JsfmtStatusView extends View
	# Essentially contains just one tool panel, with one message
  @content: ->
    @span 'jsfmt', =>
      @span outlet: 'valid', class: 'inline-block icon icon-check'
      @span outlet: 'err', class: 'inline-block icon icon-alert'

	# Start out as valid
	# TODO: Create a "working" or in-between status
  @initialize: ->
    this.isValid(true)

  # Sets the error message
  isValid: (valid) ->
    if valid
      @valid.show()
      @err.hide()
    else
      @valid.hide()
      @err.show()
