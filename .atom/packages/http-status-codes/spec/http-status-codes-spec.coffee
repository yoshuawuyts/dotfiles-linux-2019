{WorkspaceView} = require 'atom'
HttpStatusCodes = require '../lib/http-status-codes'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "HttpStatusCodes", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('http-status-codes')

  describe "when the http-status-codes:show event is triggered", ->
    it "attaches the view", ->
      expect(atom.workspaceView.find('.http-status-codes-view')).not.toExist()

      atom.workspaceView.trigger 'http-status-codes:show'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.http-status-codes-view')).toExist()
