Template.header.helpers activeRouteClass: ->
  args = Array::slice.call(arguments, 0)
  args.pop()
  active = _.any args, (name) ->
    Router.current() && Router.current().route.name == name
  active and "active"
