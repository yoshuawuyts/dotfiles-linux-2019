{CompositeDisposable} = require 'event-kit'

class MinimapColorHighlight

  views: {}
  constructor: ->
    @subscriptions = new CompositeDisposable

  activate: (state) ->
    @colorHighlightPackage = atom.packages.getLoadedPackage('atom-color-highlight')
    @minimapPackage = atom.packages.getLoadedPackage('minimap')

    return @deactivate() unless @colorHighlightPackage? and @minimapPackage?

    @MinimapColorHighlightView = require('./minimap-color-highlight-view')()

    @minimap = require @minimapPackage.path
    return @deactivate() unless @minimap.versionMatch('3.x')

    @colorHighlight = require @colorHighlightPackage.path

    @minimap.registerPlugin 'color-highlight', this

  deactivate: ->
    @deactivatePlugin()
    @minimapPackage = null
    @colorHighlightPackage = null
    @colorHighlight = null
    @minimap = null

  isActive: -> @active
  activatePlugin: ->
    return if @active

    @active = true

    @createViews() if @minimap.active

    @subscriptions.add @minimap.onDidActivate @createViews
    @subscriptions.add @minimap.onDidDeactivate @destroyViews

  deactivatePlugin: ->
    return unless @active

    @active = false
    @destroyViews()
    @subscriptions.dispose()

  createViews: =>
    return if @viewsCreated

    @viewsCreated = true
    @paneSubscription = @colorHighlight.eachColorHighlightEditor (color) =>
      editor = color.editorView.getEditor()
      pane = color.editorView.getPaneView()
      return unless pane?
      view = new @MinimapColorHighlightView color.getActiveModel(), color.editorView

      @views[editor.id] = view

      subscription = editor.getBuffer().onDidDestroy =>
        @views[editor.id]?.destroy()
        delete @views[editor.id]
        subscription.dispose()

  destroyViews: =>
    return unless @viewsCreated

    @paneSubscription.off()
    @viewsCreated = false
    view.destroy() for id,view of @views
    @views = {}

module.exports = new MinimapColorHighlight
