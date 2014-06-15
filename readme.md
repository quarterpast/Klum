# Klum

Minimal models

## Installation

```
npm install klum
```

## What's the deal

Klum models are just ES6 `Map`s that emit events when values get changed.

Klum collections forward events from their models and wrap up ES5 array methods.

That's it. Sync and serialisation can happen elsewhere. All we want to do here is track some objects with events.

## API
### `Model([initAttributes])`
#### `.all()`
Returns the collection of every instantiated model.
#### `#set(key, value)` or `#set(object)`
#### `#delete(key)`
#### `#clear`
#### `#get(key)`
#### `#has(key)`
### `Collection([initModels])`
#### `#add(model)`
#### `#reflect(eventEmitter)`
Reflect `eventEmitter`'s events, so that `eventEmitter.emit('foo')` becomes `collection.emit('foo', eventEmitter)`.
#### ES5 array extras
`map`, `filter`, `reduce`, `reduceRight`, `some`, `every`, `find`, and `concat` behave the same as their `Array` counterparts, except that:

  1. The iterator function is called with the collection as `this`
	2. The methods return new `Collection`s

## Licence

MIT. &copy; 2014 Matt Brennan
