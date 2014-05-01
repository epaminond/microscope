Template.newPosts.helpers
  options: ->
    sort: {submitted: -1}
    handle: newPostsHandle

Template.bestPosts.helpers
  options: ->
    sort: {votes: -1, submitted: -1}
    handle: topPostsHandle

Template.postsList.helpers
  posts: ->
    Posts.find {},
      sort:  @sort
      limit: @handle.limit()
  postsWithRank: ->
    i = 0
    options = { sort: @sort, limit: @handle.limit() }
    Posts.find({}, options).map (post)->
      post._rank = i
      i += 1
      post

  postsReady: -> @.handle.ready()

  allPostsLoaded: ->
    @handle.ready() && Posts.find().count() < @handle.loaded()

Template.postsList.events
  'click .load-more': (event)->
    event.preventDefault()
    @handle.loadNextPage()
