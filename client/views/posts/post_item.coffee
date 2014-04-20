Template.postItem.helpers
  ownPost: -> @.userId == Meteor.userId()
  domain: ->
    a = document.createElement('a')
    a.href = @.url
    a.hostname
  upvotedClass: ->
    userId = Meteor.userId()
    if userId && !_.include(this.upvoters, userId)
      'btn-primary upvoteable'
    else
      'disabled'

Template.postItem.events
  'click .upvoteable': (event)->
    event.preventDefault()
    Meteor.call 'upvote', @._id, (error, votes)->
      throwError error.reason if error?
