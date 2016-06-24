warni
============

[![Build Status](https://secure.travis-ci.org/mpneuried/warni.png?branch=master)](http://travis-ci.org/mpneuried/warni)
[![Windows Tests](https://img.shields.io/appveyor/ci/mpneuried/warni.svg?label=Windows%20Test)](https://ci.appveyor.com/project/mpneuried/warni)
[![Dependency Status](https://david-dm.org/mpneuried/warni.png)](https://david-dm.org/mpneuried/warni)
[![NPM version](https://badge.fury.io/js/warni.png)](http://badge.fury.io/js/warni)

A helper to count alerts and send warnings or alerts not on every event.

[![NPM](https://nodei.co/npm/warni.png?downloads=true&stars=true)](https://nodei.co/npm/warni/)

## Install

```
  npm install warni
```

## Initialize

```js
	var warnings = new Warni( { warn: 2, alert: 5, resend: 10 } );
	
	// listen to warnings
	warnings.on( "warning", function( data, count ){
		// generate your warning by sending it via Mail, Slack, HTTP or just log it to the console.
		console.warning( "WARNING! Got `" + count + "` issues of `" + data.title + "`\n" + data.details  )
	});
	
	// listen to alerts
	warnings.on( "alert", function( data, count ){
		// generate your warning by sending it via Mail, Slack, HTTP or just log it to the console.
		console.error( "ERROR! Got `" + count + "` issues of `" + data.title + "`\n" + data.details  )
	});
	
	// listen to the event until the ok was called.
	warnings.on( "ok", function( data, count ){
		// generate your warning by sending it via Mail, Slack, HTTP or just log it to the console.
		console.error( "OK! Back to normal operation after `" + count + "` issues of `" + data.title + "`\n" + data.details  )
	});
	
	// generate some issues
	for (idx = i = 0; i <= 110; idx = ++i) {
		warnings.issue( { title: "Huuuaaahhh 👻 an Error ...", details: "Just Testing ;-) with index " + idx } )
	}
	// by the configuration above th following events will be fired at index:
	// - idx=2: a warning event 
	// - idx=5: the first alert
	// - idx=50: the second alert (a resend)
	// - idx=100: the third alert (a resend)
	
	
	// if everthing is operating normal you should call
	warnings.ok( { title: "OK 👍🏼", details: "Relax ... 🍹" } )
	
```

**Config-Options** 

- **warn** : *( `Number` optional: default = `2` )* Number of `.issue()` calls needed to send a warning event. A warning event will only fired once between an `ok()` and an `alert` event.
- **alert** : *( `Number` optional: default = `5` )* Alert of `.issue()` calls to send a alert event
- **alert** : *( `Number` optional: default = `10` )* Resend a new alert event after x alert events. So only do the next alert event after `alert` * `resend` calls of `.issue()`

## Methods

#### `.issue( [data] )`

Report a problem.

**Arguments** 

- **data** : *( `Any` optional )* Additional data to describe the issue within your event handlers

**Return**

*( Warni )*: The instance itself for chaining 


#### `.ok( [data] )`

Tell Warni everything is ok and reset the issue counter if needed.

**Arguments** 

- **data** : *( `Any` optional )* Additional data to describe the issue within your event handlers

**Return**

*( Warni )*: The instance itself for chaining 

## Events

#### `warning`

An early warning, that something is fishy ;-).
This is triggered once after `.issue()` iwas called `config.warn` times.

**Arguments** 

- **data** : *( `Any` )* The latest issue data you passed to `.issue(data)`
- **count** : *( `Number` )* The count of issues called until now.

#### `alert`

Generate an alert.
This is triggered if `.issue()` was called for `config.alert` or `config.alert * config.resend` times.

**Arguments** 

- **data** : *( `Any` )* The latest issue data you passed to `.issue(data)`
- **count** : *( `Number` )* The count of issues called until now.

#### `ok`

Reported issues is gone.
Triggered when `.ok(data)` was called after a `warning` event was triggered.

**Arguments** 

- **data** : *( `Any` )* The latest issue data you passed to `.issue(data)`
- **count** : *( `Number` )* The count of issues before the `.ok()` was called.

## Todos/Ideas

 * define a time in seconds until the next alert resend is allowed. With an increase of the time with every alert. 

## Testing

The tests are based on the [mocha.js](https://mochajs.org/) framework with [should.js](https://shouldjs.github.io/) as assertaion lib.
To start the test just call

```
	npm test
```

or

```
	grunt test
```

If you want to be more precice use the mocha cli

```
	mocha -R nyan -t 1337 test/main.js
```

### Docker-Tests

If you want to test your module against multiple node versions you can use the docker tests.

**Preparation**

```sh
	# make sure you installed all dependencies
	npm install
	# build the files
	grunt build
```

**Run**

To run the tests through the defined versions run the following command:

```
	dockertests/run.sh
```


## Release History
|Version|Date|Description|
|:--:|:--:|:--|
|0.0.2|2016-6-24|Added docs and return itself on `ok` and `issue`|
|0.0.1|2016-6-23|Initial version|

[![NPM](https://nodei.co/npm-dl/warni.png?months=6)](https://nodei.co/npm/warni/)

> Initially Generated with [generator-mpnodemodule](https://github.com/mpneuried/generator-mpnodemodule)

## The MIT License (MIT)

Copyright © 2016 M. Peter, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
