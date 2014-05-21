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
    if @posts?
      @posts.rewind()
      @posts.map (post, index, cursor)->
        post._rank = index
        post

  postsReady: -> @.handle.ready()

  allPostsLoaded: ->
    @handle.ready() && Posts.find().count() < @handle.loaded()
