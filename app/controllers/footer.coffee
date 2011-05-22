Question = require("models/question")

QuestionPrompt = Spine.Prompt.create
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