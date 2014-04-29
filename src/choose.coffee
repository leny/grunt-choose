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
    for sTask, sChoice of oChoices
        aTasks.push sTask
        aChoices.push sChoice
    [ aTasks, aChoices ]

module.exports = ( grunt ) ->

    grunt.registerMultiTask "choose", "Ask the user to choose a task to run in a list.", ->

        fDone = @async()

        [ aTasks, aChoices ] = formatChoices @data.choices ? getAllTasks grunt.config.data

        oInquirerQuestion =
            type: "list"
            name: "task"
            message: "Choose the task to run now :" # TODO : allow to pass a message by option
            choices: aChoices

        inquirer.prompt oInquirerQuestion, ( oAnswer ) ->
            fDone no if ( iIndex = aChoices.indexOf oAnswer.task ) is -1
            grunt.task.run aTasks[ iIndex ]
            fDone()
