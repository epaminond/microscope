@postsHandle = Meteor.subscribeWithPagination 'posts', 10
Meteor.autorun -> Meteor.subscribe 'comments', Session.get('currentPostId')
Meteor.subscribe 'notifications'
