Question = require("models/question")

List = Spine.List.create
  template: (item) ->
    require("views/questions/list")(item)

Questions = module.exports = Spine.Controller.create
  proxied: ["render", "change"]

  init: ->
    @list = List.init(el: this.el)
    @list.bind("change", @change)
    Question.bind("change refresh", @render)

  render: ->
    @list.render(Question.all())

  change: (item) ->
    console.log(item)
    