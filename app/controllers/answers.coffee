AnswersList = Spine.List.create
  selectFirst: true

  template: (items) ->
    require("views/answers/list")(items)

module.exports = Spine.Controller.create
  elements:
    ".answers": "answers",
    ".main": "main"
    
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
    @main.html(@answersTemplate(answers))
    
    @list = AnswersList.init(el: @answers)
    @list.render(answers)
    
    @list.bind "change", (answer) =>
      element = @main.find(".item").forItem(answer).first()
      @main.animate(
        scrollTop: element.offset().top,
        200
      ) if element

  active: (item) ->
    @current = item if item
    @render()
    @trigger "active"