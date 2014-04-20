Template.postItem.helpers
  ownPost: -> @.userId == Meteor.userId()
  domain: ->
    a = document.createElement('a')
    a.href = @.url
    a.hostname
Template.postItem.events
  'click .upvote': (event)->
    event.preventDefault()
    Meteor.call 'upvote', @._id, (error, votes)->
      throwError error.reason if error?
