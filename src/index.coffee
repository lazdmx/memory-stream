through = require "through2"

#----------------------------------------
DEF_INCREMENT = 100 * 1024 # 100Kb

#----------------------------------------
module.exports = ( increment = DEF_INCREMENT ) ->
  # Data accumulator
  acc = null
  enc = null
  pos = 0

  #----------------------------------------
  transform = ( chunk, enc, done ) ->

    if Buffer.isBuffer chunk
      acc ?= new Buffer increment
      # Ensure that accumulator has sufficient space
      unless acc.length - pos >= chunk.length
        # If no, calculate amount of space we need
        needs = chunk.length - ( acc.length - pos )
        extra = increment - ( ( acc.length + needs ) % increment )
        total = acc.length + needs + extra

        # Enlarge accumulator
        tmp = new Buffer total
        acc.copy tmp, 0, 0, pos
        acc = tmp

      # Copy current chunk
      chunk.copy acc, pos
      pos += chunk.length

    else
      enc ?= enc
      acc ?= ""
      # Copy current chunk
      acc += chunk

    @push chunk
    done( )

  #----------------------------------------
  # Build stream
  stream = through transform

  #----------------------------------------
  # Returns accumulated data
  stream.remember = ->
    unless acc
      new Buffer 0

    else if Buffer.isBuffer acc
      ret = new Buffer pos
      acc.copy ret, 0, 0, pos
      ret

    else
      new Buffer acc, enc

  #----------------------------------------
  stream

