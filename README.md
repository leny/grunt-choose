# grunt-choose

![NPM version](http://img.shields.io/npm/v/grunt-choose.svg) ![Dependency Status](https://david-dm.org/leny/grunt-choose.svg) ![Downloads counter](http://img.shields.io/npm/dm/grunt-choose.svg) [![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

> Ask the user to choose a task to run in a list.

* * *

## Getting Started

This plugin requires Grunt `~0.4.3`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-choose --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-choose');
```

## The "choose" task

### Minimal usage

The minimal usage of **grunt-choose** runs with no specific configuration:

```js
choose: {
  target: {}
}
```

When used without configuration, **grunt-choose** will list all the available tasks and targets, waiting for you to choose the one to run.

### Usage with all available options

```js
choose: {
  target: {
    options: {
      message: "Please, choose a task:",
      multiple: true
    },
    choices: {
      "Show me a message !": "message:one",
      "Show me another message !": "message:two",
      "Show me another, different message !": [
        "message:three",
        "message:four"
      ]
    }
  }
}
```

#### Configuration property

##### choices
Type: `Object` or `Array` 
Default: `false`

The `choice` property lists the tasks to be selected by the user.  
If an `Object` is passed, the properties name will be used as name for the choice, the value will be treated as the task name.  
The value can be a unique task (passed as a `string`), or multiple tasks (passed as an `array`).

#### Options

#### options.message
Type: `String`
Default value: `"Choose the task to run now :"`

Invite message for the prompt.

#### options.multiple
Type: `Boolean`
Default value: `false`

Allows the user to select multiple tasks.

### Usage Examples

In this example, we ask the user to choose the next task to run.  
If the user selects "Lint my code", the task `jshint` will run. If the user selects "Lint and build", the tasks `jshint` and `build:client` will be run.

```js
choose: {
  target: {
    options: {
      message: "Please, choose a task:"
    },
    choices: {
      "Lint my code": "jshint",
      "Lint and build": [
        "jshint",
        "build:client"
      ]
    }
  }
}
```

### Advanced usage

**grunt-choose** is designed to choose and run tasks.  
If you want to do more complex things with user's prompt, please consider [grunt-prompt](https://www.npmjs.org/package/grunt-prompt).

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

**Note:** My english writing is not the best part of my work. :) If you can help me by correcting this README, please, make a Pull Request! Thanks!

## Release History

* **0.1.0**: Initial release (*29/04/14*)
* **0.1.1**: Update dependencies (*30/05/14*)

## License
Copyright (c) 2014 Leny  
Licensed under the MIT license.
