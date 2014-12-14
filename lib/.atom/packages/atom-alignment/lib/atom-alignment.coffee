Aligner = require './aligner'

matcher = ['=', ':']

module.exports =
    configDefaults:
        alignmentSpaceChars: ['=', ':']

    activate: ->
        atom.workspaceView.command 'atom-alignment:align', '.editor', ->
            editor = atom.workspaceView.getActivePaneItem()
            alignLines editor


alignLines = (editor) ->

    spaceChars     = atom.config.get('atom-alignment.alignmentSpaceChars')
    alignableLines = Aligner.alignFor editor
    # If selected lines
    if alignableLines
        # For each range
        max = 0
        matched = null
        alignableLines.forEach (range) ->


            # Split lines
            textLines = editor.getTextInBufferRange(range).split("\n")

            # If we have more one line
            textLines.forEach (a, b) ->
                # If no matcher has be set for the moment
                # We try to take on
                unless matched
                    matcher.forEach (possibleMatcher) ->
                        unless matched
                            if (a.indexOf possibleMatcher, 0) isnt -1
                                matched = possibleMatcher

                splitedString = a.split(matched)

                if splitedString.length > 1
                    splitedString[0] = splitedString[0].replace(/\s+$/g, '')
                    # Detection of max in this range
                    max = if max < splitedString[0].length then splitedString[0].length else max

        addSpacePrefix = spaceChars.indexOf(matched) > -1
        max            = max + if addSpacePrefix then 2 else 1;

        alignableLines.forEach (range) ->

            textLines = editor.getTextInBufferRange(range).split("\n")

            if max and matched

                textLines.forEach (a, b) ->
                    splitedString = a.split(matched)
                    if splitedString.length > 1
                        # Remove un needed space
                        splitedString[0] = splitedString[0].replace(/\s+$/g, '')
                        diff = max - splitedString[0].length

                        if diff > 0
                            splitedString[0] = splitedString[0] + Array(diff).join(' ')

                        if (splitedString[1] && splitedString[1].charAt(0) != ' ')
                            splitedString[1] = splitedString[1]

                        textLines[b] = splitedString.join(matched)

                editor.setTextInBufferRange(range, textLines.join('\n'));
