MinimapColorHighlight = require '../lib/minimap-color-highlight'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "MinimapColorHighlight", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('minimapColorHighlight')

  describe "when the minimap-color-highlight:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.minimap-color-highlight')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'minimap-color-highlight:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.minimap-color-highlight')).toExist()
        atom.workspaceView.trigger 'minimap-color-highlight:toggle'
        expect(atom.workspaceView.find('.minimap-color-highlight')).not.toExist()
