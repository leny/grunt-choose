
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
      var aChoices, aTasks, fDone, oInquirerQuestion, oOptions, _ref, _ref1, _ref2;
      fDone = this.async();
      oOptions = this.options();
      _ref1 = formatChoices((_ref = this.data.choices) != null ? _ref : getAllTasks(grunt.config.data)), aChoices = _ref1[0], aTasks = _ref1[1];
      oInquirerQuestion = {
        type: oOptions.multiple ? "checkbox" : "list",
        name: "tasks",
        message: (_ref2 = oOptions.message) != null ? _ref2 : "Choose the task to run now :",
        choices: aChoices
      };
      return inquirer.prompt(oInquirerQuestion, function(oAnswer) {
        var iIndex, sChoice, _i, _len, _ref3;
        if (oOptions.multiple) {
          if (!oAnswer.tasks.length) {
            return fDone();
          }
          _ref3 = oAnswer.tasks;
          for (_i = 0, _len = _ref3.length; _i < _len; _i++) {
            sChoice = _ref3[_i];
            if ((iIndex = aChoices.indexOf(sChoice)) !== -1) {
              grunt.task.run(aTasks[iIndex]);
            }
          }
        } else {
          if ((iIndex = aChoices.indexOf(oAnswer.tasks)) === -1) {
            return fDone(false);
          }
          grunt.task.run(aTasks[iIndex]);
        }
        return fDone();
      });
    });
  };

}).call(this);
