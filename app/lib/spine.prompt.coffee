Spine.Prompt = Spine.Controller.create
  events: 
    "click .close": "close"
    "click button": "submit"
    "submit form": "submit"
    
  offset:
    top: 0
    left: 0
    
  template: ->

  init: ->
    @el.addClass("prompt")
    
  render: (item) ->
    @el.hide()
    @el.html(@template(item))
    @refreshElements()
    $("body .prompt").remove();
    $("body").append(@el)
    
  offset: (offset) ->
    @el.offset(offset)
    @el.show()
    
  blOffset: (offset) ->
    offset.top = offset.top - @el.height()
    offset.top = offset.top + @offset.top
    @el.offset(offset)
    @el.show()    
    
  close: ->
    @el.remove()
    
  submit: (e) ->
    e.preventDefault()
    @close()