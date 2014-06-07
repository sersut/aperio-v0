# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ () ->
  $(".a-select-group").click (event) ->
    event.preventDefault()
    $(".a-group-selection").data("id", $(this).data("id"))
    $(".a-group-selection").data("name", $(this).data("name"))
    $(".a-selected-group-name").html($(this).data("name"))

  $(".a-post-conversation").click (event) ->
    $.ajax {
      url: '/conversations.json'
      data:
        title: $("#title").val()
        group: $(".a-group-selection").data("id")
        message: $("#message").val()
      type: 'POST'
      success: (result) ->
        document.location.href = result.uri
    }

  $('.a-post-message').click (event) ->
    $.ajax {
      url: '/conversations/' + $(this).data("conversation") + '/post'
      data:
        message: $("#message").val()
      type: 'POST'
      success: (result) ->
        $(".messages").append(result)
        $("#message").val("")
    }

  $(".a-delete-post").click (event) ->
    $.ajax {
      url: '/conversations/' + $(this).data("conversation") + ".json"
      context: this
      data:
        message: $(this).data("id")
      type: 'DELETE'
      success: (result) ->
        $(this).tooltip("destroy")
        $(this).parents(".list-group-item").remove()
        if result.uri
          document.location.href = result.uri
    }
