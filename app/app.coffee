require("lib/spine.relation")
require("spine.list")
require("spine.tabs")

Question = require("models/question")
Sidebar = require("controllers/sidebar")
Answers = require("controllers/answers")
Searches  = require("controllers/searches")

module.exports = Spine.Controller.create
  elements:
    "#sidebar": "sidebar"
    "#question": "question"
    "#search": "searches"

  init: ->
    @sidebar = Sidebar.init(el: @sidebar)
    @answers = Answers.init(el: @question)
    @searches  = Searches.init(el: @searches)
    
    Spine.Manager.init(@answers, @searches)
    
    @sidebar.bind "change", (item) =>
      @answers.active(item)
      
    @searches.bind "change", (item) =>
      @sidebar.active(item)
      @answers.active(item)
    
    $.getJSON "fixtures.json", (data) ->
      Question.refresh(data)