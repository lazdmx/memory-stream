gulp  = require "gulp"
gutil = require "gulp-util"
paths = scripts: { coffee: "src/index.coffee" }, build: "lib"

plumber = require "gulp-plumber"
changed = require "gulp-changed"
coffee  = require "gulp-coffee"

gulp.task "compile", ->
  gulp
    .src( paths.scripts.coffee )
    .pipe( plumber( ) )
    .pipe( changed( paths.build, extension: ".js" ) )
    .pipe( coffee( bare: yes ).on( "error", gutil.log ) )
    .pipe( gulp.dest( paths.build ))


gulp.task "watch", -> gulp.watch paths.scripts.coffee, [ "compile" ]
gulp.task "default", [ "compile", "watch" ]
