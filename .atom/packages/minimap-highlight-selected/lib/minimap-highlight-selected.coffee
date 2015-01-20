{CompositeDisposable} = require 'event-kit'
{requirePackages} = require 'atom-utils'
MinimapHighlightSelectedView = null

class MinimapHighlightSelected
  constructor: ->
    @subscriptions = new CompositeDisposable

  activate: (state) ->
    requirePackages('minimap', 'highlight-selected')
    .then ([@minimap, @highlightSelected]) =>
      return @deactivate() unless @minimap.versionMatch('>= 3.5.0')

      MinimapHighlightSelectedView = require('./minimap-highlight-selected-view')()

      @minimap.registerPlugin 'highlight-selected', this

  deactivate: ->
    @deactivatePlugin()
    @minimapPackage = null
    @highlightSelectedPackage = null
    @highlightSelected = null
    @minimap = null

  isActive: -> @active
  activatePlugin: ->
    return if @active

    @active = true

    @createViews()

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
    @view = new MinimapHighlightSelectedView(@minimap)
    @view.handleSelection()

  destroyViews: =>
    return unless @viewsCreated
    @viewsCreated = false
    @view.removeMarkers()
    @view.destroy()

module.exports = new MinimapHighlightSelected
