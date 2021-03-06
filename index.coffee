exec  = require('child_process').exec;
path  = require 'path'
fs    = require 'fs'

module.exports = (archivePath, options, callback) ->
  defaults = 
    target: '',
    excludeRoot: false

  escape = (cmd) ->
    return '\'' + cmd.replace(/\'/g, "'\\''") + '\''

  if typeof(options) is 'object'
    for key, value of defaults
      options[key] = value  if !options.hasOwnProperty(key)
  else
    options = defaults

  if typeof(callback) isnt 'function'
    return

  if typeof(options.target) isnt 'string' or !options.target.length
    callback new Error('Options.target is not specified.')
    return

  if options.excludeRoot
    source = '.'
    target = options.target
  else
    source = path.basename options.target
    target = path.dirname options.target
  
  archivePath = path.relative target, archivePath

  cmd = "cd #{ escape target } && zip -q -r #{ escape archivePath } #{ escape source }"
  exec cmd, (err, stdout) ->
    callback err
    return
  return
