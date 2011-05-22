Question = require("models/question")

Prompt = Spine.Controller.create
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

QuestionPrompt = Prompt.create
  offset:
    top: -40
    left: 0
    
  elements: 
    "input[type=text]": "subject"
    "textarea": "body"

  template: (items) ->
    require("views/footer/question")(items)
    
  submit: (e) ->
    e.preventDefault()
    Question.create(
      name: "User", 
      subject: @subject.val(), 
      body: @body.val()
    )
    @close()

Footer = module.exports = Spine.Controller.create
  elements:
    "[data-name=question]": "question"

  events: 
    "click [data-name=question]": "questionPrompt"

  init: ->
    
  questionPrompt: ->
    @dialog.close() if @dialog
    @dialog = QuestionPrompt.init()
    @dialog.render()
    @dialog.blOffset(@question.offset())