Question = module.exports = Spine.Model.setup("Question", ["name", "subject", "body"])

Question.extend require("models/search").Model

Question.many("answers", "models/answer")