# zip-wrapper

This package wraps the native 'zip' binary.

### Usage

```
zip(archivePath, options, function (err) {});
```

### Example

```
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
* `target` -- The target directory. Defaults to the archive's directory.
