
  jQuery ->
  $('#tasks').sortable(
    axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  )

  jQuery ->
  $('input:radio').screwDefaultButtons(
    image: "url(/assets/radioSmall.jpg)",
    width: 42.5,
    height: 42.5
  )
