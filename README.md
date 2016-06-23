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
  // TODO init code
```

**Options** 

- **foo** : *( `String` required )* TODO option description
- **bar** : *( `Number` optional: default = `123` )* TODO option description

## Todos

 * implement test cases to check for correct template generation.

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
|0.0.1|2016-6-23|Initial commit|

[![NPM](https://nodei.co/npm-dl/warni.png?months=6)](https://nodei.co/npm/warni/)

> Initially Generated with [generator-mpnodemodule](https://github.com/mpneuried/generator-mpnodemodule)

## The MIT License (MIT)

Copyright © 2016 M. Peter, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.