assert = require 'assert'
_ = require('underscore')
_.mixin require('../underscore.deep.js')

describe '_.deepKeys', ->

    _.each [
      [{}                                     , []]
      [{ a: 1 }                               , ['a']]
      [{ a: 1, b: 'two' }                     , ['a', 'b']]
      [{ a: 1, b: { c: 3 }}                   , ['a', 'b.c']]
      [{ a: []}                               , ['a']]
      [{ a: [1, 2]}                           , ['a']]
      [{ a: { b: []}}                         , ['a.b']]
      [{ a: { b: { c: 1}}}                    , [ 'a.b.c' ]]
      [{ a: {}}                               , [ 'a' ]]
      [{ a: { b: { c: {}}}}                   , [ 'a.b.c' ]]
      [{ a: 1, b: 1, c: { d: 1, e: 1 }}       , [ 'a', 'b', 'c.d', 'c.e' ]]
      [{ a: 1, b: { f: 2 }, c: { d: 1, e: 1 }}, [ 'a', 'b.f', 'c.d', 'c.e' ]]
      [{ a: 1, b: 1, c: { d: 1, e: { f: 1 }}} , [ 'a', 'b', 'c.d', 'c.e.f' ]]

    ], ([input, output]) ->
      it "extracts keys in dot notation from #{JSON.stringify input}", ->
        assert.deepEqual _.deepKeys(input), output

    _.each [
      /a/
      new Error('not a plain object')
      'Stringy McString-String'
      1
    ], (bad_input) ->
      it "throws on non-object #{JSON.stringify bad_input}", ->
        assert.throws -> _.deepKeys bad_input
