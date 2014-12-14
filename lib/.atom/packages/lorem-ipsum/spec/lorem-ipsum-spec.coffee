{WorkspaceView} = require 'atom'

describe 'lorem-ipsum', ->
    [view, editor, buffer, promise] = []

    # setup the environment before each run
    beforeEach ->
        atom.workspaceView = new WorkspaceView
        atom.workspaceView.openSync 'empty.txt'
        atom.workspaceView.attachToDom()

        atom.workspace = {}
        atom.workspace.getActiveEditor = ->
            editor

        promise = atom.packages.activatePackage('lorem-ipsum')

        view = atom.workspaceView.getActiveView()
        {editor} = view
        {buffer} = editor

    describe 'lorem-ipsum:sentence', ->
        it 'generates one sentence', ->
            # make sure it's empty
            expect(editor.getText()).toEqual ""
            view.trigger 'lorem-ipsum:sentence'

            # wait for package to activate
            waitsForPromise ->
                promise

            # make sure it's not empty
            # and a sentence
            runs ->
                text = editor.getText()
                expect(text).not.toEqual ""
                expect(text.indexOf('.') - text.length + 1).toEqual 0

    describe 'lorem-ipsum:paragraph', ->
        it 'generates one paragraph', ->

            expect(editor.getText()).toEqual ""
            view.trigger 'lorem-ipsum:paragraph'

            waitsForPromise ->
                promise

            # make sure it's not empty
            # ands with a newline
            # and has multiple sentences
            runs ->
                text = editor.getText()
                expect(text).not.toEqual ""
                expect(text.indexOf("\n") - text.length + 1).toEqual 0
                expect(text.split('.').length).toBeGreaterThan 1

    describe 'lorem-ipsum:paragraphs', ->
        it 'generates multiple paragraphs', ->

            expect(editor.getText()).toEqual ""
            view.trigger 'lorem-ipsum:paragraphs'

            waitsForPromise ->
                promise

            # makes sure it's not empty
            # has multiple paragraphs
            runs ->
                text = editor.getText()
                expect(text).not.toEqual ""
                expect(text.split("\n").length).toBeGreaterThan 1

    describe 'settings', ->
        it 'outputs one paragraph with one sentence with one word under the
            most limited settings', ->

            # set config settings to most restrictive settings
            atom.config.set 'lorem-ipsum.wordRange', [1,1]
            atom.config.set 'lorem-ipsum.sentenceRange', [1,1]
            atom.config.set 'lorem-ipsum.paragraphRange', [1,1]

            view.trigger 'lorem-ipsum:paragraphs'

            waitsForPromise ->
                promise

            # should be one paragraph, with one sentence, with one word
            runs ->
                text = editor.getText()
                expect(text.indexOf ' ').toEqual -1
