#= require_self
#= require ./application
#= require_tree ./templates
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
