require! {
	'./index.js'.Model
	'./index.js'.Collection
	'karma-sinon-expect'.expect
}

export
	'Model':
		'constructor':
			'should set attributes': ->
				m = new Model foo:\bar
				expect m.get \foo .to.be \bar

