Question = require("models/question")

List = Spine.List.create
  selectFirst: true

  template: (item) ->
    require("views/questions/list")(item)

module.exports = Spine.Controller.create
  elements: 
    ".questions": "questions"

  proxied: ["render", "change"]

  init: ->
    @list = List.init(el: @questions)
    @list.bind("change", @change)
    Question.bind("change refresh", @render)

  render: ->
    @list.render(Question.all())

  change: (item) ->
    @trigger "change", item
    