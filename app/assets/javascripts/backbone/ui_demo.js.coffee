#= require_self
#= require ./application
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.UIDemo =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  UIDemo.app.initialize()
