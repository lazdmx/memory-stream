memory-stream
=============

Passing stream that remembers data flowing through it. Data can be accessed
by `#remember` method at any time.

## Usage

```coffeescript
m = memory( )
a.pipe( m ).pipe( b ).on "end", ->
  data = m.remember( )
```


