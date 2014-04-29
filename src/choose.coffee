###
 * grunt-choose
 * https://github.com/leny/grunt-choose
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
###

"use strict"

inquirer = require "inquirer"

getAllTasks = ( oTaskData ) ->
    oTasks = {}
    for sTask, oTargets of oTaskData
        oTasks[ sTask ] = sTask
        for sTarget, oOptions of oTargets
            if sTarget isnt "options"
                sTaskAndTarget = "#{ sTask }:#{ sTarget }"
                oTasks[ sTaskAndTarget ] = sTaskAndTarget
    oTasks

formatChoices = ( oChoices ) ->
    aTasks = []
    aChoices = []
    for sChoice, sTask of oChoices
        aChoices.push sChoice
        aTasks.push sTask
    [ aChoices, aTasks ]

module.exports = ( grunt ) ->

    grunt.registerMultiTask "choose", "Ask the user to choose a task to run in a list.", ->

        fDone = @async()

        oOptions = @options()

        if !!@data.choices
            if grunt.util.kindOf( @data.choices ) is "array"
                aChoices = @data.choices
                aTasks = @data.choices
            else
                [ aChoices, aTasks ] = formatChoices @data.choices
        else
            [ aChoices, aTasks ] = formatChoices getAllTasks grunt.config.data

        oInquirerQuestion =
            type: if oOptions.multiple then "checkbox" else "list"
            name: "tasks"
            message: oOptions.message ? "Choose the task to run now :"
            choices: aChoices

        inquirer.prompt oInquirerQuestion, ( oAnswer ) ->
            if oOptions.multiple
                unless oAnswer.tasks.length
                    grunt.log.writeln "no task chosen."
                    return fDone()
                grunt.task.run aTasks[ iIndex ] for sChoice in oAnswer.tasks when ( iIndex = aChoices.indexOf sChoice ) isnt -1
            else
                return fDone no if ( iIndex = aChoices.indexOf oAnswer.tasks ) is -1
                grunt.task.run aTasks[ iIndex ]
            fDone()
