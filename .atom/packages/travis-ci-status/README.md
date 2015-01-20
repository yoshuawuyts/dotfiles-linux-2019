# Travis CI Status Package

Add Travis CI status of the project to the Atom status bar.

**Please note:** I am no longer using Atom, this means I won't be actively
maintaining this project. I will still accept pull requests for bug fixes and
such.

## Installing

Use the Atom package manager, which can be found in the Settings view or run
`apm install travis-ci-status` from the command line.

## Usage

The Travis CI build status for your repository will be indicated by the
clock-arrow icon in the status bar. The icon will appear orange when it's
requesting the build status, green if the build was successful and red if the
build failed.

The build status is updated when the project is first opened in Atom and from
then on whenever the "status" of the project repository changes. The handling of
these events was borrowed from the `git-view.coffee` part of the `status-bar`
package.

### Travis Pro

You are able to use this with Travis Pro if you enable it in the settings view.
You will also need to generate and set a
[GitHub API token](https://github.com/settings/tokens/new) to be able to
authenticate with the Travis Pro API.

### Commands

The following commands are available for users to keymap.

* `travis-ci-status:toggle` - Toggle the status bar entry
* `travis-ci-status:toggle-build-matrix` - Toggle the build matrix panel
* `travis-ci-status:open-on-travis` - Open the project on the Travis CI site

## Coming Soon

* Better icon for the status bar

Feel free to open an issue to discuss potential features to add or improve.

## Support

If you wish to support this package and help further its development, feel free
to tip via Gittip.

[![Gittip](http://img.shields.io/gittip/tombell.png)](https://www.gittip.com/tombell/)
