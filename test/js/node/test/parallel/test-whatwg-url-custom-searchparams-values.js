'use strict';

// Tests below are not from WPT.

require('../common');
const assert = require('assert');

const params = new URLSearchParams('a=b&c=d');
const values = params.values();

assert.strictEqual(typeof values[Symbol.iterator], 'function');
assert.strictEqual(values[Symbol.iterator](), values);
assert.deepStrictEqual(values.next(), {
  value: 'b',
  done: false
});
assert.deepStrictEqual(values.next(), {
  value: 'd',
  done: false
});
assert.deepStrictEqual(values.next(), {
  value: undefined,
  done: true
});
assert.deepStrictEqual(values.next(), {
  value: undefined,
  done: true
});

assert.throws(() => {
  values.next.call(undefined);
}, {
  code: 'ERR_INVALID_THIS',
  name: 'TypeError',
  message: 'Cannot call next() on a non-Iterator object'
});
assert.throws(() => {
  params.values.call(undefined);
}, {
  code: 'ERR_INVALID_THIS',
  name: 'TypeError',
  message: 'Can only call URLSearchParams.values on instances of URLSearchParams'
});
