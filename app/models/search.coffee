Search = module.exports = Spine.Class.sub()
Search.include Spine.Events

classMethods = 
  query: (params) ->
    @select (rec) ->
      rec.query params
    
instanceMethods =
  query: (params) ->
    attributes = @query_atts?() || @attributes()
    for key of attributes
      value = attributes[key]
      if value?.query?(params).length
        return true
      else if value && typeof value == "string"
        value = value.toLowerCase()
        return true if value.indexOf(params) != -1
    return false

Search.Model = 
  extended: ->
    @extend  classMethods
    @include instanceMethods

Search.include
  init: (models...) ->
    @models  = models
    @results = []
    
  query: (params) ->
    @clear()
    return unless params
    @params = params.toLowerCase()
    @models.forEach (model) =>
      results  = model.query(@params)
      @results = @results.concat(results)
    @trigger "change"
    
  clear: ->
    @results = []
    @trigger "change"
    
  each: (callback) ->
    @results.forEach(callback)