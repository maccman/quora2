require("lib/spine.relation")
require("spine.list")
require("spine.tabs")

Question = require("models/question")
Sidebar = require("controllers/sidebar")
Answers = require("controllers/answers")
Search  = require("controllers/search")

module.exports = Spine.Controller.create
  elements:
    "#sidebar": "sidebar"
    "#question": "question"
    "#search": "search"

  init: ->
    @sidebar = Sidebar.init(el: @sidebar)
    @answers = Answers.init(el: @question)
    @search  = Search.init(el: @search)
    
    Spine.Manager.init(@answers, @search)
    
    @sidebar.bind "change", (item) =>
      @answers.active(item)
    
    $.getJSON "fixtures.json", (data) ->
      Question.refresh(data)