AtomAlignment = require '../lib/atom-alignment'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomAlignment", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('atomAlignment')

  # describe "when the atom-alignment:align event is triggered", ->
  #   it "attaches and then detaches the view", ->
  #     expect(atom.workspaceView.find('.atom-alignment')).not.toExist()
  #
  #     # This is an activation event, triggering it will cause the package to be
  #     # activated.
  #     atom.workspaceView.trigger 'atom-alignment:toggle'
  #
  #     waitsForPromise ->
  #       activationPromise
  #
  #     runs ->
  #       expect(atom.workspaceView.find('.atom-alignment')).toExist()
  #       atom.workspaceView.trigger 'atom-alignment:toggle'
  #       expect(atom.workspaceView.find('.atom-alignment')).not.toExist()
