'use strict';

var request = require('request');

var TravisHttp = function (endpoint) {
    this.apiEndpoint = endpoint;
};

TravisHttp.prototype._getHeaders = function () {
    var headers = {
        'Accept': 'application/vnd.travis-ci.2+json, */*; q=0.01'
    };
    if (this._getAccessToken()) {
        headers.Authorization = 'token ' + this._getAccessToken();
    }
    return headers;
};

TravisHttp.prototype._request = function (method, path, json, callback) {
    if (typeof json === 'function') {
        callback = json;
        json = undefined;
    }

    request({
        method: method,
        url: this.apiEndpoint + path,
        json: json,
        headers: this._getHeaders()
    }, function (err, res) {
        if (err) {
            callback(err);
        } else if (res.statusCode >= 400) {
            callback(res.hasOwnProperty('body') ? JSON.stringify(res.body) : res.statusCode);
        } else {
            callback(null, res.body);
        }
    });
};

TravisHttp.prototype._get = function (path, json, callback) {
    this._request('GET', path, json, callback);
};

TravisHttp.prototype._post = function (path, json, callback) {
    this._request('POST', path, json, callback);
};
TravisHttp.prototype._put = function (path, json, callback) {
    this._request('PUT', path, json, callback);
};

TravisHttp.prototype._setAccessToken = function (accessToken) {
    this._accessToken = accessToken;
};

TravisHttp.prototype._getAccessToken = function () {
    return this._accessToken;
};

module.exports = TravisHttp;
