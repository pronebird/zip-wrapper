// Generated by CoffeeScript 1.9.3
(function() {
  var exec, fs, path;

  exec = require('child_process').exec;

  path = require('path');

  fs = require('fs');

  module.exports = function(archivePath, options, callback) {
    var cmd, defaults, escape, key, source, target, value;
    defaults = {
      target: '',
      excludeRoot: false
    };
    escape = function(cmd) {
      return '\'' + cmd.replace(/\'/g, "'\\''") + '\'';
    };
    if (typeof options === 'object') {
      for (key in defaults) {
        value = defaults[key];
        if (!options.hasOwnProperty(key)) {
          options[key] = value;
        }
      }
    } else {
      options = defaults;
    }
    if (typeof callback !== 'function') {
      return;
    }
    if (typeof options.target !== 'string' || !options.target.length) {
      callback(new Error('Options.target is not specified.'));
      return;
    }
    if (options.excludeRoot) {
      source = '.';
      target = options.target;
    } else {
      source = path.basename(options.target);
      target = path.dirname(options.target);
    }
    archivePath = path.relative(target, archivePath);
    cmd = "cd " + (escape(target)) + " && zip -q -r " + (escape(archivePath)) + " " + (escape(source));
    exec(cmd, function(err, stdout) {
      callback(err);
    });
  };

}).call(this);
