assert = require 'assert'
_ = require('underscore')
_.mixin require('../underscore.deep.js')

describe '_.deepMapKeys', ->
  _.each [
    "foo"
    String
    5
    null
    []
  ], (input) ->
    it "throws on non object '#{input}'", ->
      assert.throws (-> _.deepMapKeys input, (v) -> v),
        /deepMapKeys must be called on an object/

  it "maps over an empty object", ->
    res = _.deepMapKeys {}, (val) -> assert.fail "shouldn't have called map fn"
    assert.deepEqual res, {}

  it "maps add_ over a flat object", ->
    res = _.deepMapKeys { a: 1, b: 2 }, (val) -> val + '_'
    assert.deepEqual res, { a_: 1, b_: 2 }

  it "maps add_ over a deep object", ->
    res = _.deepMapKeys { a: { b: 1, c: 2 }, d: e: f: 3 }, (k) -> k + '_'
    assert.deepEqual res, { a_: { b_: 1, c_: 2 }, d_: e_: f_: 3 }
