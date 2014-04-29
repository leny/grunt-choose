###
 * grunt-choose
 * https://github.com/Leny/grunt-choose
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
###

"use strict"

module.exports = ( grunt ) ->

    grunt.registerMultiTask "choose", "Ask the user to choose a task to run in a list.", ->

        grunt.log.writeln "There's many things TODO here."

        console.log grunt.config
