# Public: Pluralize a string based on the number.
#
# number - The number to check.
#
# Examples
#
#   "hour".pluralize(2) # "hours"
#
# Returns a pluralized string if the number isn't 1, else the same string.
String::pluralize = (number) ->
  this + (if number isnt 1 then 's' else '')

# Publix: Formatted the number of seconds.
#
# Examples
#
#   "120".formattedDuration()   # "2 mins"
#   "10825".formattedDuration() # "3 hours and 25 secs"
#
# Returns a formatted string.
String::formattedDuration = ->
  seconds = parseInt(this, 10)

  hours = Math.floor seconds / 3600
  mins = Math.floor (seconds - (hours * 3600)) / 60
  secs = seconds - (hours * 3600) - (mins * 60)

  duration = ''
  duration += "#{hours} #{"hour".pluralize(hours)} " if hours > 0
  duration += "#{mins} #{"min".pluralize(mins)} " if mins > 0
  duration += "#{secs} #{"sec".pluralize(secs)}" if secs > 0
  duration
