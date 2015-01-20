{View} = require 'atom'

require './extensions'

module.exports =
# Internal: The main view for displaying the build matrix from Travis-CI.
class BuildMatrixView extends View
  # Internal: Build up the HTML contents for the fragment.
  @content: ->
    @div class: 'travis-ci-status tool-panel panel-bottom padded native-key-bindings', tabIndex: -1, =>
      @div class: 'build-matrix block', =>
        @div class: 'message', outlet: 'matrix', =>
          @p class: 'matrix-title', outlet: 'title', 'No build matrix fetched'
          @ul class: 'builds', outlet: 'builds'

  # Internal: Initialize the view.
  #
  # nwo - The string of the repo owner and name.
  initialize: (@nwo) ->
    @matrix.css('font-size', "#{atom.config.get('editor.fontSize')}px")

    atom.workspaceView.command 'travis-ci-status:toggle-build-matrix', =>
      @toggle()

  # Internal: Serialize the state of this view.
  #
  # Returns an object containing key/value pairs of state data.
  serialize: ->

  # Internal: Attach the build matrix segment to the workspace.
  #
  # Returns nothing.
  attach: ->
    atom.workspaceView.prependToBottom(this)

  # Internal: Destroy the view and tear down any state.
  #
  # Returns nothing.
  destroy: ->
    @detach()

  # Internal: Toggle the visibility of the view.
  #
  # Returns nothing.
  toggle: ->
    if @hasParent()
      @detach()
    else
      @attach()

  # Internal: Update the repository build matrix from Travis CI.
  #
  # buildId - The string or number of the build ID.
  #
  # Returns nothing.
  update: (buildId) =>
    @title.text('Fetching build matrix...')
    details = @nwo.split '/'
    atom.travis.repos(details[0], details[1]).builds(buildId).get(@buildMatrix)

  # Internal: Callback for the Travis CI build status, updates the build matrix.
  #
  # err  - The error object if there was an error, else null.
  # data - The object of parsed JSON returned from the API.
  #
  # Returns nothing.
  buildMatrix: (err, data) =>
    @matrix.removeClass('pending success fail')
    return console.log "Error:", err if err?

    number = data['build']['number']
    if data['build']['duration']
      duration = data['build']['duration'].toString()

      @title.text("Build #{number} took #{duration.formattedDuration()}")
      @builds.empty()
      @addBuild(build) for build in data['jobs']

  # Internal: Add the build details to the builds list.
  #
  # build - The object of build details from the matrix array.
  #
  # Returns nothing.
  addBuild: (build) =>
    status = if build['state'] is 'passed' then 'success' else 'fail'

    started = new Date(build['started_at'])
    finished = new Date(build['finished_at'])

    duration = ((finished - started) / 1000).toString()

    @builds.append("""
      <li class='#{status}'>
        #{build['number']} - #{duration.formattedDuration()} >>> <a target="_new" href="https://travis-ci.org/#{@nwo}/builds/#{build['build_id']}">Full Report...</a>
      </li>
    """)
