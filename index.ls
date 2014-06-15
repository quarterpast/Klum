require! {
	Map: 'es6-map'
	eventide
}

class exports.Collection implements eventide
	(@models = [])->
		@models.for-each @~reflect

	add: (model)->
		@models.push model
		@reflect model

	remove: (model)->
		model.emit \remove
		@models = [m for m in @models when m isnt model]
		model.off-any model._forward-listener

	reflect: (model)->
		model._forward-listener = (event, ...args)~>
			@emit event, model, ...args

		model.on-any model._forward-listener

	models-fn = (k)->
		Collection[k] = (fn, ...args)-> new @constructor @models[k] (fn.bind this), ...args

	<[ map filter reduce reduceRight some every find indexOf lastIndexOf ]> .for-each models-fn

	concat: (o)->
		new @constructor (@models ++ o.models)

class exports.Model extends Map implements eventide
	@all = ->
		@collection ?= new Collection

	(attrs)->
		super!
		@set attrs
		@@all!.add this
		@emit \create

	set: (attr, value)->
		if typeof! attr is \Object
			for key, value of attr
				@set key, value
		else
			@emit "change:#attr" value
			super ...

	delete: (attr)->
		@emit "delete:#attr"
		super ...
	
	clear: ->
		@emit \reset
		super ...
