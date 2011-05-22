Answer = module.exports = Spine.Model.setup("Answer", ["name", "body"])
Answer.extend require("models/search").Model

Answer.include
  validate: ->
    return "Name required" unless @name
    return "Body required" unless @body