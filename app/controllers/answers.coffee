AnswersList = Spine.List.create
  selectFirst: true

  template: (items) ->
    require("views/answers/list")(items)

module.exports = Spine.Controller.create
  elements:
    ".answersNav": "answersNav",
    ".answers": "answers"
    "textarea": "bodyInput"
    
  events:
    "submit form": "create"

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
      @answers.prop(scrollTop: element.offset().top) if element
      
  create: (e) ->
    e.preventDefault()
    return unless @current
    @current.answers.create(
      name: "Joe Public",
      body: @bodyInput.val()
    )
    @bodyInput.val("")
    @render()

  active: (item) ->
    @current = item if item
    @render()
    @trigger "active"