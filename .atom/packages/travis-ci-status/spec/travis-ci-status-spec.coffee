TravisCiStatus = require "../lib/travis-ci-status"
{$, WorkspaceView, View} = require "atom"

class StatusBarMock extends View
  @content: ->
    @div class: "status-bar tool-panel panel-bottom", =>
      @div outlet: "leftPanel", class: "status-bar-left"

  attach: ->
    atom.workspaceView.appendToTop(this)

  appendLeft: (item) ->
    @leftPanel.append(item)

describe "TravisCiStatus", ->
  beforeEach ->
    spyOn(TravisCiStatus, "isTravisProject").andCallFake((cb) -> cb(true))

    atom.workspaceView = new WorkspaceView
    atom.workspaceView.statusBar = new StatusBarMock()
    atom.workspaceView.statusBar.attach()
    atom.packages.emit("activated")

  describe "when the travis-ci-status:toggle event is triggered", ->
    beforeEach ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "git@github.com:test/test.git"
      })

    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find(".travis-ci-status")).not.toExist()

      waitsForPromise ->
        atom.packages.activatePackage("travis-ci-status")

      runs ->
        expect(atom.workspaceView.find(".travis-ci-status")).toExist()

  describe "can get the nwo if the project is a github repo", ->
    it "gets nwo of https repo ending in .git", ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "https://github.com/tombell/travis-ci-status.git"
      })

      nwo = TravisCiStatus.getNameWithOwner()
      expect(nwo).toEqual("tombell/travis-ci-status")

    it "gets nwo of https repo not ending in .git", ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "https://github.com/tombell/test-status"
      })

      nwo = TravisCiStatus.getNameWithOwner()
      expect(nwo).toEqual("tombell/test-status")

    it "gets nwo of ssh repo ending in .git", ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "git@github.com:tombell/travis-ci-status.git"
      })

      nwo = TravisCiStatus.getNameWithOwner()
      expect(nwo).toEqual("tombell/travis-ci-status")

    it "gets nwo of ssh repo not ending in .git", ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "git@github.com:tombell/test-status"
      })

      nwo = TravisCiStatus.getNameWithOwner()
      expect(nwo).toEqual("tombell/test-status")
