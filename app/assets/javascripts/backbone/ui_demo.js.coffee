#= require_self
#= require_tree ./templates
#= require ./application
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#= require_tree ./initializers

window.UIDemo =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  UIDemo.app.initialize()
