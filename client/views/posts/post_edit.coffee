Template.postEdit.events
  'submit form': (e)->
    e.preventDefault()
    postProperties =
      url: $(e.target).find('[name=url]').val()
      title: $(e.target).find('[name=title]').val()
    Posts.update @_id, {$set: postProperties}, (error)->
      if error then throwError(error.reason) else
        Router.go 'postPage', _id: @_id
  'click .delete': (e)->
    e.preventDefault()
    if confirm "Delete this post?"
      Posts.remove @_id
      Router.go 'postsList'
