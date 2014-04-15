Router.map ->
  @.route 'postsList', path: '/'
  @.route 'postPage',
    path: '/posts/:_id',
    data: -> Session.set 'currentPostId', @.params._id
  @.route 'postEdit',
    path: '/posts/:_id/edit',
    data: -> Session.set 'currentPostId', @.params._id
  @.route 'postSubmit', path: '/submit'

Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

requireLogin = (pause)->
  if !Meteor.user()
    if Meteor.loggingIn()
      @.render @.loadingTemplate
    else
      @.render 'accessDenied'
    pause()

Router.onBeforeAction 'loading'
Router.onBeforeAction requireLogin, only: 'postSubmit'
Router.onBeforeAction -> clearErrors()