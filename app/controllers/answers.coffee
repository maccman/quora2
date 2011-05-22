Question = require("models/question")
Answer = require("models/answer")

AnswerPrompt = Spine.Prompt.create
  offset:
    top: -40
    left: 0
    
  elements: 
    "textarea": "body"

  template: (items) ->
    require("views/questions/answer")(items)

  submit: (e) ->
    e.preventDefault()
    @item.answers.create(
      name: "Joe Blogs", 
      body: @body.val()
    )
    @item.trigger "change"
    @close()

AnswersList = Spine.List.create
  selectFirst: true

  template: (items) ->
    require("views/answers/list")(items)

module.exports = Spine.Controller.create
  elements:
    ".answersNav": "answersNav",
    ".answers": "answers"
    "footer [data-name=answer]": "answerBtn"
    
  events:
    "click footer [data-name=answer]": "answerPrompt"
    
  init: ->
    Question.bind "change", =>
      @render() if @current

  template: (item) ->
    require("views/questions/panel")(item)
    
  answersTemplate: (item) ->
    require("views/answers/show")(item)
    
  render: ->
    unless @current
      @deactivate()
      return
    
    @el.html(@template(@current))
    @refreshElements()
    @renderAnswers()
    
  renderAnswers: ->
    return unless @current
    
    answers = @current.answers.all()
    @answers.html(@answersTemplate(answers))
    
    @list = AnswersList.init(el: @answersNav)
    @list.render(answers)
    
    @list.bind "change", (answer) =>
      element = @answers.find(".item").forItem(answer).first()
      @answers.scrollTop(element[0].offsetTop - 10) if element[0]

  active: (item) ->
    @current = item if item
    @render()
    @trigger "active"
    
  answerPrompt: ->
    @dialog.close() if @dialog
    @dialog = AnswerPrompt.init(item: @current)
    @dialog.render()
    @dialog.blOffset(@answerBtn.offset())