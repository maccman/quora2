Search = require("models/search")
Question = require("models/question")

module.exports = Spine.Controller.create
  proxied: ["keyup", "change"]
  
  events:
    "click .item": "click"

  init: ->
    @el.html(require("views/searches/panel")())
    
    @search = Search.init(Question)
    @search.bind "change", @change
    
    @input = $("#searchInput")
    @input.bind "keyup", @keyup
    
  keyup: ->
    @query = @input.val()
    @search.query(@query)
    
  template: (items) ->
    require("views/searches/list")(items)

  change: ->
    @$(".query").text @query
    @$(".items").html @template(@search.results)
    @active()
  
  click: (e) ->
    question = $(e.target).item()
    @trigger "change", question