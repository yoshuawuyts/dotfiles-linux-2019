window.lorem = require 'lorem-ipsum'

module.exports =

    # defaults settings
    # TODO, find a way to validate numbers
    configDefaults:
        wordRange: [6,15]
        sentenceRange: [4,10]
        paragraphRange: [3,5]

    ###
    Called when a lorem-ipsum command is called
    Actives the package
    ###
    activate: ->

        # listen for events
        atom.workspaceView.command '
            lorem-ipsum:sentence
            lorem-ipsum:paragraph
            lorem-ipsum:paragraphs', @generate


    ###
    Outputs lorem ipsum text into the editor pane
    Handles lorem-ipsum:(sentence|paragraph|paragraphs)
    ###
    generate: ({type}) ->

        # get variables and create basic options
        editor = atom.workspace.getActiveEditor()
        config = atom.config.get('lorem-ipsum')
        options =
            units: 'paragraphs'
            format: 'plain'
            sentenceLowerBound: parseInt config.wordRange[0]
            sentenceUpperBound: parseInt config.wordRange[1]
            paragraphLowerBound: parseInt config.sentenceRange[0]
            paragraphUpperBound: parseInt config.sentenceRange[1]
            count: 1

        # customize options if necessary
        options.units = 'sentence' if type == 'lorem-ipsum:sentence'
        options.count = Math.floor(
            parseInt(config.paragraphRange[0]) + Math.random() *
            parseInt(config.paragraphRange[1] - config.paragraphRange[0] + 1)
        ) if type == 'lorem-ipsum:paragraphs'

        # generate text and insert it at cursor(s)
        editor?.insertText lorem options
