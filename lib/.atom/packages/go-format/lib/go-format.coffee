exec = require('child_process').exec

GoFormatStatusView = require('./go-format-status-view')

module.exports =
  view: null

  configDefaults:
    executable: 'go fmt'
    formatOnSave: true

  activate: (state) ->
    @view = new GoFormatStatusView(state.viewState)
    atom.project.eachEditor (editor) =>
      @attachEditor(editor)
    atom.subscribe atom.project, 'editor-created', (editor) =>
      @attachEditor(editor)

    atom.workspaceView.command 'go-format:format', =>
      editor = atom.workspace.getActiveEditor()
      if editor
        @format(editor)

  deactivate: ->
    @view.destroy()
    atom.unsubscribe(atom.project)

  serialize: ->
    viewState: @view.serialize()

  attachEditor: (editor) ->
    atom.subscribe editor.getBuffer(), 'reloaded saved', =>
      if atom.config.get('go-format.formatOnSave')
        @format(editor)
    atom.subscribe editor.getBuffer(), 'destroyed', =>
      atom.unsubscribe(editor.getBuffer())

  command: (editor) ->
    executable = atom.config.get('go-format.executable')
    cmd = "#{executable} #{editor.getPath()}"
    "bash --login -c '#{cmd.replace(/'/g, "\\'")}'"

  format: (editor) ->
    if editor and editor.getPath()
      scope = editor.getCursorScopes()[0]
      if scope is 'source.go'
        editorView = atom.workspaceView.getActiveView()
        if editorView.gutter and editorView.gutter.attached
          editorView.gutter.removeClassFromAllLines('go-format-error')
          editorView.gutter.find('.go-format-error-msg').remove()

        exec @command(editor), (err, stdout, stderr) =>
          if not err or err.code is 0
            @view.html('').hide()
          else
            console.log("[go-format save error]: " + stderr)
            message = 'Format error.'
            if stderr.match(/No such file or directory/)
              message = 'Cannot find gofmt executable.'
            editorView = atom.workspaceView.getActiveView()
            if editorView.gutter and editorView.gutter.attached
              stderr.split(/\r?\n/).forEach (line) ->
                match = line.match(/^.+?:(\d+):(\d+):\s+(.+)/)
                if match
                  lineNo = parseInt(match[1]) - 1
                  editorView.gutter.addClassToLine(lineNo, 'go-format-error')
                  lineEl = editorView.gutter.find('.line-number-' + lineNo)
                  if lineEl.size() > 0
                    lineEl.prepend('<abbr class="go-format-error-msg" title="' +
                      match[2] + ': ' + match[3] + '">✘</abbr>')

            @view.html('<span class="error">' + message + '</span>').show()
