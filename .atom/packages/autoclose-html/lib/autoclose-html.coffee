concatPattern = /\s*[,|]+\s*/g
isTagLikePattern = /<(?![\!\/])([a-z]{1}[^>\s=\'\"]*)/i
isOpeningTagLikePattern = /<(?![\!\/])([a-z]{1}[^>\s=\'\"]*)/i
isClosingTagLikePattern = /<\/([a-z]{1}[^>\s=\'\"]*)/i

module.exports =

    configDefaults:
        closeOnEndOfOpeningTag: false
        neverClose: 'br, hr, img, input, link, meta, area, base, col, command, embed, keygen, param, source, track, wbr'
        makeNeverCloseElementsSelfClosing: false
        forceInline: 'title, h1, h2, h3, h4, h5, h6'
        forceBlock: ''
        additionalGrammars: ''

    neverClose:[]
    forceInline: []
    forceBlock: []
    grammars: ['HTML']
    makeNeverCloseSelfClosing: false
    ignoreGrammar: false

    activate: () ->
        #keeping this to correct the old value
        atom.config.observe 'autoclose-html.ignoreGrammar', (value) =>
            if value is true
                atom.config.set 'autoclose-html.additionalGrammars', '*'
                @ignoreGrammar = true
            atom.config.set 'autoclose-html.ignoreGrammar', null

        atom.config.observe 'autoclose-html.neverClose', (value) =>
            @neverClose = value.split(concatPattern)

        atom.config.observe 'autoclose-html.forceInline', (value) =>
            @forceInline = value.split(concatPattern)

        atom.config.observe 'autoclose-html.forceBlock', (value) =>
            @forceBlock = value.split(concatPattern)

        atom.config.observe 'autoclose-html.additionalGrammars', (value) =>
            if(value.indexOf('*') > -1)
                @ignoreGrammar = true
            else
                @grammars = ['HTML'].concat(value.split(concatPattern))

        atom.config.observe 'autoclose-html.makeNeverCloseElementsSelfClosing', (value) =>
            @makeNeverCloseSelfClosing = value

        @_events()

    isInline: (eleTag) ->
        ele = document.createElement eleTag

        if eleTag.toLowerCase() in @forceBlock
            return false
        else if eleTag.toLowerCase() in @forceInline
            return true

        document.body.appendChild ele
        ret = window.getComputedStyle(ele).getPropertyValue('display') in ['inline', 'inline-block', 'none']
        document.body.removeChild ele

        ret

    isNeverClosed: (eleTag) ->
        eleTag.toLowerCase() in @neverClose

    execAutoclose: (changedEvent, editor) ->
        if changedEvent.newText is '>'
            line = editor.buffer.getLines()[changedEvent.newRange.end.row]
            partial = line.substr 0, changedEvent.newRange.start.column

            return if partial.substr(partial.length - 1, 1) is '/'

            return if not (matches = partial.substr(partial.lastIndexOf('<')).match isOpeningTagLikePattern)?

            eleTag = matches[matches.length - 1]
            if @isNeverClosed(eleTag)
                if @makeNeverCloseSelfClosing
                    setTimeout ->
                        tag = '/>'
                        if partial.substr partial.length - 1, 1 isnt ' '
                            tag = ' ' + tag
                        editor.backspace()
                        editor.insertText tag
                return

            isInline = @isInline eleTag

            setTimeout ->
                if not isInline
                    editor.insertNewline()
                    editor.insertNewline()
                editor.insertText('</' + eleTag + '>')
                if isInline
                    editor.setCursorBufferPosition changedEvent.newRange.end
                else
                    editor.autoIndentBufferRow changedEvent.newRange.end.row + 1
                    editor.setCursorBufferPosition [changedEvent.newRange.end.row + 1, atom.workspace.activePaneItem.getTabText().length * atom.workspace.activePaneItem.indentationForBufferRow(changedEvent.newRange.end.row + 1)]

    _events: () ->
        atom.workspace.observeTextEditors (textEditor) =>
            bufferEvent = null
            textEditor.observeGrammar (grammar) =>
                bufferEvent.dispose() if bufferEvent?
                if grammar.name?.length > 0 and (@ignoreGrammar or grammar.name in @grammars)
                    bufferEvent = textEditor.buffer.onDidChange (e) =>
                        if e?.newText is '>'
                            @execAutoclose e, textEditor
