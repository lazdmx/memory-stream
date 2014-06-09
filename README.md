memory-stream
=============

[![Build Status](https://travis-ci.org/lazutkin/memory-stream.svg?branch=develop)](https://travis-ci.org/lazutkin/memory-stream)

Passing stream that remembers data flowing through it. Passed data can be accessed at any time by
by `#remember` method.

## Usage

```coffeescript
memory = require "x-memory-stream"

# Creates memory stream which will increment internal buffer by ~10Kb step. Default step is ~100Kb
m = memory 10 * 1024

a.pipe( m ).pipe( b ).on "finish", ->
  # Get remembered data
  data = m.remember( )
```



