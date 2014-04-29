
/*
 * grunt-choose
 * https://github.com/Leny/grunt-choose
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
 */

(function() {
  "use strict";
  module.exports = function(grunt) {
    return grunt.registerMultiTask("choose", "Ask the user to choose a task to run in a list.", function() {
      grunt.log.writeln("There's many things TODO here.");
      return console.log(grunt.config);
    });
  };

}).call(this);
