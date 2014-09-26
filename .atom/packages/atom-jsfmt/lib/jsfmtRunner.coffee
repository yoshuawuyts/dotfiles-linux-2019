#
# JsfmtRunner - Runs jsfmt on your code. 
# This replaces jsfmt.coffee and doesn't rely on spawning a child process
#

ErrorView = require './errorView'
jsfmt = require 'jsfmt'
fs = require 'fs'
path = require 'path'

module.exports = 
class JsfmtRunner
  
  @start: =>
    # Commands
    atom.workspaceView.command 'atom-jsfmt:format', => @formatCurrent()
    atom.workspaceView.command 'atom-jsfmt:format-all-open-files', => @formatAllOpen()
    
    # Editor listeners
    atom.workspaceView.eachEditorView @registerEditor
    
    
  @registerEditor: (editorView) =>
    editor = editorView.getEditor()
    
    # Editor may be created before view
    if !editor._jsfmt?.errorView
      errorView = new ErrorView()
      editorView.append(errorView)
    
      editor._jsfmt = {errorView}
    
    else
      editorView.append(editor._jsfmt.errorView);
    
    editor.getBuffer().on 'saved' , =>
      editor._jsfmt.errorView.hide()
      shouldFormat = atom.config.get 'atom-jsfmt.formatOnSave' 
      
      if shouldFormat and @editorIsJs editor
        @format(editor)
  
  
  @format: (editor) ->
    # May not be a view for the editor yet.
    if !editor._jsfmt
      errorView = new ErrorView()
      editor._jsfmt = {errorView}
      
    errorView = editor._jsfmt?.errorView
    buff = editor.getBuffer()
    oldJs = buff.getText()
    newJs = ''
    
    # Attempt to format, log errors
    try
      newJs = jsfmt.format oldJs
    catch error
      console.log 'Jsfmt:', error.message, error
      errorView.setMessage(error.message)
      return
    
    # Apply diff only. 
    buff.setTextViaDiff newJs   
    buff.save() if atom.config.get 'atom-jsfmt.saveAfterFormatting'
    
  
  @formatCurrent: () ->
    editor = atom.workspace.getActiveEditor()
    @format editor if @editorIsJs editor
    
  @formatAllOpen: () ->
    editors = atom.workspace.getEditors()
    @format editor for editor in editors when @editorIsJs editor
    
  @editorIsJs: (editor) ->
    return editor.getGrammar().scopeName is 'source.js'
    