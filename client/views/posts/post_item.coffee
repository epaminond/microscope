POST_HEIGHT = 80
Positions = new Meteor.Collection null

Template.postItem.helpers
  ownPost: -> @.userId == Meteor.userId()
  domain: ->
    a = document.createElement('a')
    a.href = @.url
    a.hostname
  upvotedClass: ->
    userId = Meteor.userId()
    if userId && !_.include(@upvoters, userId)
      'btn-primary upvoteable'
    else
      'disabled'
  attributes: ->
    post = _.extend({}, Positions.findOne(postId: @_id), @)
    newPosition = post._rank * POST_HEIGHT
    attributes = {}
    if _.isUndefined(post.position)
      attributes.class = "post invisible"
    else
      delta = post.position - newPosition
      attributes.style = "top: " + delta + "px"
      attributes.class = "post animate"  if delta is 0
    Meteor.setTimeout ->
      Positions.upsert {postId: post._id}, {$set: {position: newPosition}}
    attributes

Template.postItem.events
  'click .upvoteable': (event)->
    event.preventDefault()
    Meteor.call 'upvote', @._id, (error, votes)->
      throwError error.reason if error?
