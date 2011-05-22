require("lib/spine.relation")
require("lib/spine.prompt")
require("spine.list")
require("spine.tabs")

Question = require("models/question")
Sidebar = require("controllers/sidebar")
Answers = require("controllers/answers")
Searches  = require("controllers/searches")
Footer = require("controllers/footer")

module.exports = Spine.Controller.create
  elements:
    "#sidebar": "sidebar"
    "#question": "question"
    "#search": "searches"
    "#footer": "footer"

  init: ->
    @sidebar = Sidebar.init(el: @sidebar)
    @answers = Answers.init(el: @question)
    @searches  = Searches.init(el: @searches)
    @footer = Footer.init(el: @footer)
    
    Spine.Manager.init(@answers, @searches)
    
    @sidebar.bind "change", (item) =>
      @answers.active(item)
      
    @searches.bind "change", (item) =>
      @sidebar.active(item)
      @answers.active(item)
    
    $.getJSON "fixtures.json", (data) ->
      Question.refresh(data)