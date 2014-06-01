var DEF_INCREMENT, through;

through = require("through2");

DEF_INCREMENT = 100 * 1024;

module.exports = function(increment) {
  var acc, enc, pos, stream, transform;
  if (increment == null) {
    increment = DEF_INCREMENT;
  }
  acc = null;
  enc = null;
  pos = 0;
  transform = function(chunk, enc, done) {
    var extra, needs, tmp, total;
    if (Buffer.isBuffer(chunk)) {
      if (acc == null) {
        acc = new Buffer(increment);
      }
      if (!(acc.length - pos >= chunk.length)) {
        needs = chunk.length - (acc.length - pos);
        extra = increment - ((acc.length + needs) % increment);
        total = acc.length + needs + extra;
        tmp = new Buffer(total);
        acc.copy(tmp, 0, 0, pos);
        acc = tmp;
      }
      chunk.copy(acc, pos);
      pos += chunk.length;
    } else {
      if (enc == null) {
        enc = enc;
      }
      if (acc == null) {
        acc = "";
      }
      acc += chunk;
    }
    this.push(chunk);
    return done();
  };
  stream = through(transform);
  stream.remember = function() {
    var ret;
    if (!acc) {
      return new Buffer(0);
    } else if (Buffer.isBuffer(acc)) {
      ret = new Buffer(pos);
      acc.copy(ret, 0, 0, pos);
      return ret;
    } else {
      return new Buffer(acc, enc);
    }
  };
  return stream;
};
