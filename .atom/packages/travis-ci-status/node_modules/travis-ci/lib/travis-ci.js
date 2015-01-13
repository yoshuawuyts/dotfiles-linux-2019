'use strict';

var _ = require('lodash');
var util = require('util');
var _s = require('underscore.string');
var TravisHttp = require('./travis-http');
var GitHub = require('github');
var assert = require('assert');

var getRouteApiPathRaw = function (route) {
    var segments = _s.words(_s.trim(route.uri, '/'), '/');
    return _.filter(segments, function (segment) {
        return segment[0] !== ':';
    });
};

var getRouteApiPath = function (route) {
    return _.map(getRouteApiPathRaw(route), function (segment) {
        return _s.camelize(segment);
    });
};

var getRouteApiArguments = function (route) {
    var segments = _s.words(_s.trim(route.uri, '/'), '/');
    return _.map(_.map(_.filter(segments, function (segment) {
        return segment[0] === ':';
    }), function (argument) {
        // strip off the : that denotes an argument name
        return argument.substr(1);
    }), function (arg) {
        // strip off the optional ? after the argument name
        return (arg.substr(-1) === '?') ? arg.substr(0, arg.length -1) : arg;
    });
};

var fillRouteArguments = function (route, args) {
    var filledRoute = route.uri;
    _.each(route.args, function (arg) {
        filledRoute = filledRoute.replace(new RegExp(':' + arg + '\\??'), args[arg]);
    });
    return filledRoute;
};

var getRoutesWithSatisfiedArgumentRequirements = function (routes, args) {
    var normalizedArgs = _.map(args, function (value, key) {
        return _s.camelize(key);
    });
    return _.filter(routes, function (route) {
        var apiArgs = _.map(route.args, function (arg) {
            return _s.camelize(arg);
        });

        return _.isEqual(apiArgs, _.intersection(apiArgs, normalizedArgs));
    });
};

var createObjectChain = function (obj, names) {
    var last = obj;
    for (var i in names) {
        var name = names[i];

        if (!last.hasOwnProperty(name)) {
            last[name] = {};
        }

        last = last[name];
    }
    return last;
};

var TRAVIS_ENDPOINT = 'https://api.travis-ci.org';
var TRAVIS_PRO_ENDPOINT = 'https://api.travis-ci.com';

var TravisClient = function (config) {
    this.pro = config.pro || false;
    TravisHttp.call(this, this.pro ? TRAVIS_PRO_ENDPOINT : TRAVIS_ENDPOINT);

    if (!config.hasOwnProperty('version')) {
        throw 'must specify api version';
    }

    var version = config.version;
    var routes = _.flatten(_.pluck(require('../api/v' + version + '/routes.json'), 'routes'), true);

    _.each(routes, function (route) {
        route.path = getRouteApiPath(route);
        route.args = getRouteApiArguments(route);
    });

    var routePathApis = _.groupBy(routes, 'path');
    _.each(routePathApis, this._addRoute, this);
};
util.inherits(TravisClient, TravisHttp);

TravisClient.prototype._authenticateAccessToken = function (msg, callback) {
    assert(_.isObject(msg), msg);
    assert(msg.hasOwnProperty('access_token'), msg);
    assert(_.isFunction(callback));
    this._get('/users', msg, function (err) {
        if (err) { return callback(err); }

        this._setAccessToken(msg.access_token);
        return callback(null, msg);
    }.bind(this));
};

TravisClient.prototype._authenticateGithubToken = function (msg, callback) {
    assert(_.isObject(msg), msg);
    assert(msg.hasOwnProperty('github_token'), msg);
    assert(_.isFunction(callback));
    this.auth.github(msg, function (err, res) {
        if (err) { return callback(err); }

        this._authenticateAccessToken(res, callback);
    }.bind(this));
};

TravisClient.prototype._authenticateBasic = function (msg, callback) {
    assert(_.isObject(msg), msg);
    assert(msg.hasOwnProperty('username'), msg);
    assert(msg.hasOwnProperty('password'), msg);
    assert(_.isFunction(callback));

    var GITHUB_TRAVIS_APP_INFO = {
        app: {
            name: 'Travis CI',
            url: 'https://travis-ci.org'
        }
    };
    var GITHUB_TRAVIS_PRO_APP_INFO = {
        app: {
            name: 'Travis CI Pro',
            url: 'https://travis-ci.com'
        }
    };

    var github = new GitHub({
        version: '3.0.0'
    });
    github.authenticate({
        type: 'basic',
        username: msg.username,
        password: msg.password
    });

    github.authorization.getAll({}, function (err, res) {
        if (err) { return callback(err); }
        var app = _.findWhere(res, this.pro ? GITHUB_TRAVIS_PRO_APP_INFO : GITHUB_TRAVIS_APP_INFO);

        if (!app) {
            return callback('travis github token not found');
        }

        this._authenticateGithubToken({
            github_token: app.token
        }, callback);
    }.bind(this));
};

TravisClient.prototype.authenticate = function (msg, callback) {
    if (!_.isFunction(callback)) {
        throw new Error('expected callback to be a function');
    }

    if (!_.isObject(msg)) {
        return callback('expected an object');
    }

    if (_.difference(_.keys(msg), ['username', 'password']).length === 0) {
        return this._authenticateBasic(msg, callback);
    } else if (_.difference(_.keys(msg), ['access_token']).length === 0) {
        return this._authenticateAccessToken(msg, callback);
    } else if (_.difference(_.keys(msg), ['github_token']).length === 0) {
        return this._authenticateGithubToken(msg, callback);
    } else {
        return callback('unexpected arguments');
    }
};

TravisClient.prototype.isAuthenticated = function () {
    return !!this._getAccessToken();
};

TravisClient.prototype._addRoute = function (routes) {
    var path = routes[0].path;

    var functionName = _.last(path);
    var last = createObjectChain(this, _.initial(path));

    var apiFunctionWrapper = function (msg, callback) {
        // Make msg an optional argument
        if (_.isFunction(msg) && _.isUndefined(callback)) {
            callback = msg;
            msg = {};
        }

        if (!_.isFunction(callback)) {
            throw new Error('expected callback to be a function');
        }
 
        if (!_.isObject(msg)) {
            return callback('expected msg to be an object');
        }

        // Get all routes that have their argument list satisfied, 
        // regardless of extra parameters.
        var matchingRoutes = getRoutesWithSatisfiedArgumentRequirements(routes, msg);

        if (matchingRoutes.length === 0) {
            return callback('invalid arguments');
        } else {
            // We'll blindly use the route that has the most satisfied arguments
            // 
            // So if we find ourselves with the following routes and arguments:
            // GET /repos/:owner_name/:name/builds/:id
            // GET /repos/:owner_name/:name/builds
            // {
            //     owner_name:
            //     name:
            //     id:
            // }
            // 

            // group the matching routes based on how many args matched...
            // we want to use a route that had the most matched args
            var routeGroups = _.groupBy(matchingRoutes, function (route) {
                return route.args.length;
            });
            // returns { 1: {}, 2 {}}

            // groupBy makes an obj with the number of matches the key...
            // flatten this into a 2d array of groups of routes, sorted by
            // number of matched args
            var sortedRouteGroups = _.sortBy(routeGroups, function (group, key) {
                return Number(key).valueOf();
            });
            // returns [[],[],[]], where the last group is the one with the most matches

            var routeGroup = _.last(sortedRouteGroups);
            // use the first route defined if there is ambiguity (hopefully the GET request)
            var route = _.first(routeGroup);

            // If we're trying to access an endpoint that requires authentication,
            // we must either be authenticated, or be passing in an access token.
            if (route.scope === 'private' && !this.isAuthenticated() && !msg.hasOwnProperty('access_token')) {
                return callback('authentication required');
            }

            // Url args are the ones that aren't filled in as part of the route.
            var args = _.omit(msg, route.args);
            // Replace the :args with the args provided.
            var url = fillRouteArguments(route, msg);

            switch (route.verb) {
            case 'GET':
                this._get(url, args, callback);
                break;
            case 'POST':
                this._post(url, args, callback);
                break;
            case 'PUT':
                this._put(url, args, callback);
                break;
            default:
                throw new Error('unsupported http verb');
            }
        }

    }.bind(this);

    if(last.hasOwnProperty(functionName)) {
        throw new Error('trying to create an api wrapper that already exists for ' + functionName + ' ' + path);
    }
    last[functionName] = apiFunctionWrapper;
};


module.exports = TravisClient;