module.exports = map

function map(list, iterator, context, callback) {
    var keys = Object.keys(list)
        , returnValue = Array.isArray(list) ? [] : {}
        , count = keys.length

    if (typeof context === "function") {
        callback = context
        context = this
    }

    if (keys.length === 0) {
        return callback(null, returnValue)
    }

    for (var i = 0, len = keys.length; i < len; i++) {
        var key = keys[i]
            , value = list[key]

        invokeIterator(iterator,
            next(key), context, value, key, list)
    }

    function next(key) {
        return handler

        function handler(err, newValue) {
            if (err) {
                return callback && callback(err)
            }

            returnValue[key] = newValue

            if (--count === 0) {
                callback && callback(null, returnValue)
            }
        }
    }
}

function invokeIterator(iterator, done, self, value, key, list) {
    var length = iterator.length

    if (length === 1) {
        iterator.call(self, done)
    } else if (length === 2) {
        iterator.call(self, value, done)
    } else if (length === 3) {
        iterator.call(self, value, key, done)
    } else {
        iterator.call(self, value, key, list, done)
    }
}
