Question = module.exports = Spine.Model.setup("Question", ["name", "subject", "body"])

Question.many("answers", "models/answer")