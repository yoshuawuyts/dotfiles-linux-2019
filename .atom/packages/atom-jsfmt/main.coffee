JsfmtRunner = require './lib/jsfmtRunner'

module.exports =

  # Configuration
  configDefaults:
    showErrors: true # Whether or not to show the error bar
    formatOnSave: true # Whether or not to format automatically
    saveAfterFormatting: false # Whether or not to save after formatting

  # Start things up
  activate: ->
    JsfmtRunner.start()
