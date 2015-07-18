# zip-wrapper

[![npm version](http://img.shields.io/npm/v/zip-wrapper.svg?style=flat)](https://npmjs.org/package/zip-wrapper "View this project on npm")
[![Build Status](https://travis-ci.org/pronebird/zip-wrapper.svg?branch=master)](https://travis-ci.org/pronebird/zip-wrapper)

This package wraps the native 'zip' binary.

### Install

Available on npm:

```sh
npm install zip-wrapper
```

### Usage

```js
zip(archivePath, options, function (err) {});
```

### Example

```js
var zip = require('zip-wrapper');

var options = {
  target: '/folder/to/archive' 
};

zip('/path/to/archive.zip', options, function (err) {
  if(err) {
    console.log(err.message);
    return;
  }
  console.log('Zipped folder!');
});
```

The following options are available:

* `excludeRoot` -- Whether compressed directory should be a root entry of ZIP file. Defaults to false.
* `target` -- The target directory.
