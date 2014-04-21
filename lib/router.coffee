Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  waitOn: ->
    [Meteor.subscribe("notifications")]

# PostsListController = RouteController.extend
#   template: "postsList"
#   increment: 5
#   limit: -> parseInt(@params.postsLimit) or @increment
#   findOptions: ->
#     sort: @sort
#     limit: @limit()
#   waitOn: -> Meteor.subscribe "posts", @findOptions()
#   posts: -> Posts.find {}, @findOptions()
#   data: ->
#     hasMore = @posts().count() is @limit()
#     posts: @posts()
#     nextPath: (if hasMore then @nextPath() else null)

# NewPostsListController = PostsListController.extend
#   sort:
#     submitted: -1
#     _id: -1

#   nextPath: ->
#     Router.routes.newPosts.path postsLimit: @limit() + @increment

# BestPostsListController = PostsListController.extend
#   sort:
#     votes: -1
#     submitted: -1
#     _id: -1

#   nextPath: ->
#     Router.routes.bestPosts.path postsLimit: @limit() + @increment

# Router.map ->
#   @route "home",
#     path: "/"
#     controller: NewPostsListController

#   @route "newPosts",
#     path: "/new/:postsLimit?"
#     controller: NewPostsListController

#   @route "bestPosts",
#     path: "/best/:postsLimit?"
#     controller: BestPostsListController

#   @route "postPage",
#     path: "/posts/:_id"
#     waitOn: ->
#       [
#         Meteor.subscribe("singlePost", @params._id)
#         Meteor.subscribe("comments", @params._id)
#       ]

#     data: ->
#       Posts.findOne @params._id

#   @route "postEdit",
#     path: "/posts/:_id/edit"
#     waitOn: ->
#       Meteor.subscribe "singlePost", @params._id

#     data: ->
#       Posts.findOne @params._id

#   @route "postSubmit",
#     path: "/submit"
#     progress:
#       enabled: false

#   return

Router.map ->
  @.route 'bestPosts', path: '/'
  @.route 'bestPosts', path: '/best'
  @.route 'newPosts', path: '/new'
  @.route 'postPage',
    path: '/posts/:_id',
    data: -> Session.set 'currentPostId', @.params._id
  @.route 'postEdit',
    path: '/posts/:_id/edit',
    data: -> Session.set 'currentPostId', @.params._id
  @.route 'postSubmit', path: '/submit'

requireLogin = (pause) ->
  unless Meteor.user()
    if Meteor.loggingIn()
      @render @loadingTemplate
    else
      @render "accessDenied"
    pause()

Router.onBeforeAction 'loading'
Router.onBeforeAction requireLogin, only: 'postSubmit'
Router.onBeforeAction -> clearErrors()