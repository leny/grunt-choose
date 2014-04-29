###
 * grunt-choose
 * https://github.com/leny/grunt-choose
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
###

"use strict"

module.exports = ( grunt ) ->

  require( "matchdep" ).filterDev( "grunt-*" ).forEach grunt.loadNpmTasks

  grunt.initConfig
    coffeelint:
      options:
        arrow_spacing:
          level: "error"
        camel_case_classes:
          level: "error"
        duplicate_key:
          level: "error"
        indentation:
          level: "ignore"
        max_line_length:
          level: "ignore"
        no_backticks:
          level: "error"
        no_empty_param_list:
          level: "error"
        no_stand_alone_at:
          level: "error"
        no_tabs:
          level: "error"
        no_throwing_strings:
          level: "error"
        no_trailing_semicolons:
          level: "error"
        no_unnecessary_fat_arrows:
          level: "error"
        space_operators:
          level: "error"
      task:
        files:
          src: [ "src/*.coffee" ]
    coffee:
      task:
        files:
            "tasks/choose.js": "src/choose.coffee"
    watch:
      server:
        files: [
          "src/*.coffee"
        ]
        options:
          nospawn: yes
        tasks: [
          "clear"
          "newer:coffeelint:server"
          "newer:coffee:server"
        ]
    choose:
      default_options:
        options: {}
      simple_options:
        options: {}
        choices:
          "Show me a message !": "message:one"
          "Show me another message !": "message:two"
          "Show me another, different message !": [
            "message:three"
            "message:four"
          ]

  grunt.loadTasks "tasks"

  grunt.registerTask "message", "Display a message", ( arg ) ->
    grunt.log.writeln switch( arg )
      when "one" then "Hey ! This is task message:one !"
      when "two" then "Hey ! This is task message:two !"
      when "three" then "Hey ! This is task message:three !"
      when "four" then "Hey ! This is task message:four !"
      when "five" then "Hey ! This is task message:five !"
      else "Hey ! This is task message:default !"

  grunt.registerTask "default", [
    "clear"
    "coffeelint"
    "coffee"
  ]
