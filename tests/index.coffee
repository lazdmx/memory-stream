_s     = require "underscore.string"
chai   = require "chai"
memory = require ".."
expect = chai.expect

d = "Faucibus orci luctus et ultrices posuere cubilia Curae.
     Phasellus ipsum odio, suscipit nec, fringilla at, vehicula quis, tellus.
     Phasellus gravida condimentum dui. Aenean imperdiet arcu vitae ipsum. Duis
     dapibus, nisi non porttitor iaculis, ligula odio sollicitudin mauris, non
     luctus nunc massa a velit. Fusce ac nisi. Integer volutpat elementum metus.
     Vivamus luctus."


#----------------------------------------
it "should return empty buffer", ->
  x = memory( ).remember( )
  expect( x ).to.have.length 0
  expect( Buffer.isBuffer x ).to.be.ok


#----------------------------------------
it "should remember data #1", ->
  s = memory( )
  
  s.write x for x in _s.chop d, 9
  s.end( )
  expect( s.remember( ).toString( ) ).to.be.equal d


#----------------------------------------
it "should remember data #2", ->
  s = memory 7

  s.write x for x in _s.chop d, 9
  s.end( )
  expect( s.remember( ).toString( ) ).to.be.equal d
