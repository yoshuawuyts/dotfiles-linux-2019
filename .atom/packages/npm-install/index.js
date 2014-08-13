var core = require('resolve/lib/core.json')
var JSONParse = require('safe-json-parse')
var ansihtml = require('ansi-html-stream')
var spawn = require('child_process').spawn
var remove = require('remove-element')
var coffee = require('coffee-script')
var detective = require('detective')
var domify = require('domify')
var findup = require('findup')
var path = require('path')
var fs = require('fs')

exports.activate = activate
exports.deactivate = deactivate

var messages = {
    cantFind: "Hmm... Couldn't find any packages to install!"
  , oneAtATime: "Sorry, you can only run one installation at a time"
  , alreadyInstalled: "Hey, looks like everything has already been installed!"
}

var panel
var inner
var npm

function activate() {
  atom.workspaceView.command('npm-install:save', save({ dev: false }))
  atom.workspaceView.command('npm-install:save-dev', save({ dev: true }))
}

function deactivate() {
  npm.exit()
  inner.innerHTML = ''
  remove(panel)
  remove(inner)
}

function notice(message, className) {
  var overlay = document.createElement('div')

  overlay.setAttribute('class', 'overlay npm-install from-bottom')
  overlay.innerText = message

  if (className) overlay.classList.add(className)

  atom.workspaceView.append(overlay)

  setTimeout(function() {
    overlay.classList.add('fade-out')
  }, 4000)

  setTimeout(function() {
    remove(overlay)
  }, 4500)
}

function save(opts) {
  opts = opts || {}

  inner = inner || document.createElement('div')
  panel = panel || document.createElement('div')
  panel.setAttribute('class', 'panel-bottom tool-panel npm-install')
  panel.appendChild(inner)
  inner.setAttribute('class', 'terminal')

  return function() {
    var editor = atom.workspace.activePaneItem
    var view = atom.workspaceView

    var data = editor.getBuffer().cachedText
    var file = editor.getPath()
    var cwd = path.dirname(file)

    var dkey = opts.dev
      ? 'devDependencies'
      : 'dependencies'

    var flag = opts.dev
      ? '--save-dev'
      : '--save'

    try {
      var found = detective(path.extname(file) === '.coffee'
        ? coffee.compile(data)
        : data
      )
    } catch(e) {
      return notice(e.message, 'warning')
    }

    found = found.filter(function(module) {
      return core.indexOf(module) === -1
    }).map(function(module) {
      return module.split('/')[0]
    }).filter(function(module) {
      return module !== '.'
    })

    if (!found.length) return notice(messages.cantFind)
    if (!(cwd = findup.sync(cwd, 'package.json'))) return

    var pkgFile = path.join(cwd, 'package.json')
    var pkgData = fs.readFileSync(pkgFile, 'utf8')

    JSONParse(pkgData, function(err, pkg) {
      if (err) return console.error(err)

      var output = ansihtml()
      var deps = []
        .concat(Object.keys(pkg.dependencies || {}))
        .concat(Object.keys(pkg.devDependencies || {}))
        .concat(Object.keys(pkg.peerDependencies || {}))

      found = found.filter(function(module) {
        return deps.indexOf(module) === -1
      })

      if (!found.length) return notice(messages.alreadyInstalled, 'success')
      if (npm) return notice(messages.oneAtATime, 'warning')

      npm = spawn('npm', [
          'install'
        , '--color=always'
        , flag
      ].concat(found), {
          cwd: cwd
        , env: process.env
      })

      npm.stdout.pipe(output)
      npm.stderr.pipe(output)
      npm.once('exit', function(code) {
        npm = null
        if (code === 0) return setTimeout(remove.bind(null, panel), 1000)
        notice('Invalid exit code from npm: ' + code, 'warning')
      })

      inner.innerHTML = ''
      output.on('data', function(data) {
        inner.innerHTML += data
      })

      if (!panel.parentNode)
        view.appendToBottom(panel)
    })
  }
}
