@Posts = new Meteor.Collection 'posts'

Meteor.methods
  post: (postAttributes)->
    user = Meteor.user()
    postWithSameLink = Posts.findOne url: postAttributes.url

    # ensure the user is logged in
    throw new Meteor.Error(401, "You need to login to post new stories") if !user

    # ensure the post has a title
    throw new Meteor.Error(422, 'Please fill in a headline') if !postAttributes.title

    # check that there are no previous posts with the same link
    if postAttributes.url && postWithSameLink
      throw new Meteor.Error 302, 'This link has already been posted',
        postWithSameLink._id

    # pick out the whitelisted keys
    post = _.extend _.pick(postAttributes, 'url', 'title', 'message'),
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
    postId = Posts.insert post
    postId
