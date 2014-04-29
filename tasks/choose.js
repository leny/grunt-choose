
/*
 * grunt-choose
 * https://github.com/Leny/grunt-choose
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
 */

(function() {
  "use strict";
  var getAllTasks;

  getAllTasks = function(oTaskData) {
    var oOptions, oTargets, oTasks, sTarget, sTask, sTaskAndTarget;
    oTasks = {};
    for (sTask in oTaskData) {
      oTargets = oTaskData[sTask];
      oTasks[sTask] = sTask;
      for (sTarget in oTargets) {
        oOptions = oTargets[sTarget];
        if (sTarget !== "options") {
          sTaskAndTarget = "" + sTask + ":" + sTarget;
          oTasks[sTaskAndTarget] = sTaskAndTarget;
        }
      }
    }
    return oTasks;
  };

  module.exports = function(grunt) {
    return grunt.registerMultiTask("choose", "Ask the user to choose a task to run in a list.", function() {
      var oChoices, _ref;
      grunt.log.writeln("There's many things TODO here.");
      oChoices = (_ref = this.data.choices) != null ? _ref : getAllTasks(grunt.config.data);
      return console.log(oChoices);
    });
  };

}).call(this);
