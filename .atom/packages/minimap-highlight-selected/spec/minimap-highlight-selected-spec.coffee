{WorkspaceView} = require 'atom'
MinimapHighlightSelected = require '../lib/minimap-highlight-selected'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "MinimapHighlightSelected", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView

    waitsForPromise ->
      atom.packages.activatePackage('minimap-highlight-selected')
