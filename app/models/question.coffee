Question = module.exports = Spine.Model.setup("Question", ["name", "subject", "body"])

Question.extend require("models/search").Model

Question.many("answers", "models/answer")

Question.include
  validate: ->
    return "Name required" unless @name
    return "Subject required" unless @subject