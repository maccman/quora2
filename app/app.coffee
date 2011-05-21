require("lib/spine.relation")
require("spine.list")
require("spine.tabs")

Question = require("models/question")
Questions = require("controllers/questions")

module.exports = Spine.Controller.create
  elements:
    "#questions": "questions"

  init: ->
    this.questions = Questions.init(el: this.questions)
    
    $.getJSON "fixtures.json", (data) ->
      Question.refresh(data)