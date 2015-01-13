module.exports.inline = {
  resets:    { '0': false },
  bold:      { '1': { style: 'font-weight:bold' } },
  underline: { '4': { style: 'text-decoration:underline' } },
  foregrounds: {
      '30': { style: 'color:#111' } // black
    , '31': { style: 'color:#ff7e76' } // red
    , '32': { style: 'color:#a4f87b' } // green
    , '33': { style: 'color:#f6fcc0' } // yellow
    , '34': { style: 'color:#9cd8fb' } // blue
    , '35': { style: 'color:#ff85f6' } // magenta
    , '36': { style: 'color:#cfd0f8' } // cyan
    , '37': { style: 'color:#eee' } // white
    , '39': false // default
  },
  backgrounds: {
      '40': { style: 'background-color:#111' } // black
    , '41': { style: 'background-color:#ff7e76' } // red
    , '42': { style: 'background-color:#a4f87b' } // green
    , '43': { style: 'background-color:#f6fcc0' } // yellow
    , '44': { style: 'background-color:#9cd8fb' } // blue
    , '45': { style: 'background-color:#ff85f6' } // magenta
    , '46': { style: 'background-color:#cfd0f8' } // cyan
    , '47': { style: 'background-color:#eee' } // white
    , '49': false // default
  }
};

module.exports.classes = {
  resets:    { '0': false },
  bold:      { '1': { 'class': 'ansi-bold' } },
  underline: { '4': { 'class': 'ansi-underline' } },
  foregrounds: {
      '30': { 'class': 'ansi-fg-black' }
    , '31': { 'class': 'ansi-fg-red' }
    , '32': { 'class': 'ansi-fg-green' }
    , '33': { 'class': 'ansi-fg-yellow' }
    , '34': { 'class': 'ansi-fg-blue' }
    , '35': { 'class': 'ansi-fg-magenta' }
    , '36': { 'class': 'ansi-fg-cyan' }
    , '37': { 'class': 'ansi-fg-white' }
    , '39': false // default
  },
  backgrounds: {
      '40': { 'class': 'ansi-bg-black' }
    , '41': { 'class': 'ansi-bg-red' }
    , '42': { 'class': 'ansi-bg-green' }
    , '43': { 'class': 'ansi-bg-yellow' }
    , '44': { 'class': 'ansi-bg-blue' }
    , '45': { 'class': 'ansi-bg-magenta' }
    , '46': { 'class': 'ansi-bg-cyan' }
    , '47': { 'class': 'ansi-bg-white' }
    , '49': false // default
  }
};
