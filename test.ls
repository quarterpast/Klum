require! {
	'./index.js'.Model
	'./index.js'.Collection
	'karma-sinon-expect'.expect
	eventide
}

class Ev implements eventide

export
	'Model':
		'all':
			'should be a collection': ->
				expect Model.all! .to.be.a Collection
			'should save the collection': ->
				Model.all!
				expect Model.collection .to.be Model.all!

		'constructor':
			'should set attributes': ->
				m = new Model foo:\bar
				expect m.get \foo .to.be \bar
			'should add to collection': ->
				m = new Model
				expect Model.all!.models .to.contain m
			'should emit create event': ->
				c = Model.all!
				c.on \create handler = expect.sinon.stub!
				m = new Model
				expect handler .to.be.called-with m
		'set':
			'should set key-value pair': ->
				m = new Model
				m.set \foo \bar
				expect m.get \foo .to.be \bar
			'should set object': ->
				m = new Model
				m.set do
					foo: \bar
					baz: \quux
				expect m.get \foo .to.be \bar
				expect m.get \baz .to.be \quux
			'should emit change event with attribute and value': ->
				m = new Model
				m.on \change handler = expect.sinon.stub!
				m.set \foo \bar
				expect handler .to.be.called-with \foo \bar
		'delete':
			'should emit delete event': ->
				m = new Model
				m.on \delete handler = expect.sinon.stub!
				m.delete \foo
				expect handler .to.be.called-with \foo
		'clear':
			'should emit reset event': ->
				m = new Model
				m.on \reset handler = expect.sinon.stub!
				m.clear!
				expect handler .to.be.called!

	'Collection':
		'reflect':
			'should forward events from models': ->
				c = new Collection
				c.reflect m = new Ev
				c.on \test handler = expect.sinon.stub!
				m.emit \test
				expect handler .to.be.called-with m

		'constructor':
			'should add models': ->
				c = new Collection [m = new Ev]
				expect c.models .to.contain m

		'remove':
			'should remove model from the collection': ->
				c = new Collection [m = new Ev]
				c.remove m
				expect c.models .not.to.contain m
			'should unregister event handler': ->
				c = new Collection [m = new Ev]
				c.on \foo handler = expect.sinon.stub!
				c.remove m
				m.emit \foo
				expect handler .to.be.not-called!
			'should fire a remove event': ->
				c = new Collection [m = new Ev]
				m.on \remove handler = expect.sinon.stub!
				c.remove m
				expect handler .to.be.called!
