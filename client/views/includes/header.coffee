Template.header.helpers activeRouteClass: ->
  args = Array::slice.call(arguments, 0)
  args.pop()
  active = _.any args, (name) ->
    Router.current() and Router.current().route.name is name
  active and "active"
