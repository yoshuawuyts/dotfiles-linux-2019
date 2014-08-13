#
# Module dependencies
#

path = require 'path'

#
# Set Makefile[.any extension] and '.mk' files to always use hard tabs
#

atom.workspaceView.eachEditorView (editorView) ->
  editor = editorView.getEditor()
  if path.basename(editor.getPath()) is 'Makefile'
    editor.setSoftTabs(false)
  if path.extname(editor.getPath()) is '.mk'
    editor.setSoftTabs(false)

# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to make opened Markdown files always be soft wrapped:
#
# path = require 'path'
#
# atom.workspaceView.eachEditorView (editorView) ->
#   editor = editorView.getEditor()
#   if path.extname(editor.getPath()) is '.md'
#     editor.setSoftWrap(true)
