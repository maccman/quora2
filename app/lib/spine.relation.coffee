Spine.Model.extend 
  one: (name, model) ->
    @attributes.push(name)

    sub = ->
      if typeof model is "string"
        require(model) 
      else model
      
    @.bind "init", (record) ->
      return if record[name] and record[name].record
      record[name] = sub.init(record[name])
      record[name].newRecord = false

  many: (name, model) ->
    @attributes.push(name)

    sub = ->
      if typeof model is "string"
        require(model).sub()
      else model.sub()
    
    @.bind "init", (record) ->
      attribute    = record[name]
      record[name] = sub()
      if attribute
        record[name].refresh(
          attribute.records or attribute
        )