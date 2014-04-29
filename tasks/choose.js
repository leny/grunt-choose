
/*
 * grunt-choose
 * https://github.com/leny/grunt-choose
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
 */

(function() {
  "use strict";
  var formatChoices, getAllTasks, inquirer;

  inquirer = require("inquirer");

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

  formatChoices = function(oChoices) {
    var aChoices, aTasks, sChoice, sTask;
    aTasks = [];
    aChoices = [];
    for (sChoice in oChoices) {
      sTask = oChoices[sChoice];
      aChoices.push(sChoice);
      aTasks.push(sTask);
    }
    return [aChoices, aTasks];
  };

  module.exports = function(grunt) {
    return grunt.registerMultiTask("choose", "Ask the user to choose a task to run in a list.", function() {
      var aChoices, aTasks, fDone, oInquirerQuestion, _ref, _ref1;
      fDone = this.async();
      _ref1 = formatChoices((_ref = this.data.choices) != null ? _ref : getAllTasks(grunt.config.data)), aChoices = _ref1[0], aTasks = _ref1[1];
      oInquirerQuestion = {
        type: "list",
        name: "task",
        message: "Choose the task to run now :",
        choices: aChoices
      };
      return inquirer.prompt(oInquirerQuestion, function(oAnswer) {
        var iIndex;
        if ((iIndex = aChoices.indexOf(oAnswer.task)) === -1) {
          fDone(false);
        }
        grunt.task.run(aTasks[iIndex]);
        return fDone();
      });
    });
  };

}).call(this);
