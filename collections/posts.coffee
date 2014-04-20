@Posts = new Meteor.Collection 'posts'

Posts.allow
  update: @ownsDocument
  remove: @ownsDocument

Posts.deny
  update: (userId, post, fieldNames)->
    # may only edit the following fields:
    _.without(fieldNames, 'url', 'title').length > 0

Meteor.methods
  post: (postAttributes)->
    user = Meteor.user()
    postWithSameLink = Posts.findOne url: postAttributes.url

    throw new Meteor.Error(401, "You need to login to post new stories") if !user
    throw new Meteor.Error(422, 'Please fill in a headline') if !postAttributes.title
    if postAttributes.url && postWithSameLink
      throw new Meteor.Error 302, 'This link has already been posted',
        postWithSameLink._id

    post = _.extend _.pick(postAttributes, 'url', 'title', 'message'),
      userId:        user._id
      author:        user.username
      submitted:     new Date().getTime()
      commentsCount: 0
      upvoters:      []
      votes:         0
    Posts.insert post

  upvote: (postId)->
    user = Meteor.user()
    throw new Meteor.Error(401, "You need to login to upvote") if (!user)

    Posts.update {
      _id: postId
      upvoters: {$ne: user._id}
    }, {
      $addToSet: {upvoters: user._id}
      $inc: {votes: 1}
    }
