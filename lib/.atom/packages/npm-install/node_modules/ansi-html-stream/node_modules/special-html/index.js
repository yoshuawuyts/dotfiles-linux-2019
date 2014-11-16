module.exports = function(oldstring) {
  var newstring = ''
    , i = 0
    , l = oldstring.length
    , character

  for (i; i < l; i += 1) {
    character = oldstring.charCodeAt(i)
    if (character > 127) {
      newstring += '&#' + character + ';'
    } else {
      newstring += oldstring[i]
    }
  }


  return newstring
};
