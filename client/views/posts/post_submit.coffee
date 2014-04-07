Template.postSubmit.events
  'submit form': (event)->

    event.preventDefault()

    post =
      url:     $(event.target).find('[name=url]').val()
      title:   $(event.target).find('[name=title]').val()
      message: $(event.target).find('[name=message]').val()

    Meteor.call 'post', post, (error, id)->
      if error
        throwError error.reason
        Meteor.Router.go('postPage', error.details) if error.error == 302
      else
        Meteor.Router.go 'postPage', id
      Router.go 'postPage', _id: id
