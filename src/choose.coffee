###
 * grunt-choose
 * https://github.com/leny/grunt-choose
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
###

"use strict"

getAllTasks = ( oTaskData ) ->
    oTasks = {}
    for sTask, oTargets of oTaskData
        oTasks[ sTask ] = sTask
        for sTarget, oOptions of oTargets
            if sTarget isnt "options"
                sTaskAndTarget = "#{ sTask }:#{ sTarget }"
                oTasks[ sTaskAndTarget ] = sTaskAndTarget
    oTasks

module.exports = ( grunt ) ->

    grunt.registerMultiTask "choose", "Ask the user to choose a task to run in a list.", ->

        oChoices = @data.choices ? getAllTasks grunt.config.data

        console.log grunt.config
