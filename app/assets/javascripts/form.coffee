init = ->
  $startDate = $('#start-date')
  $endDate = $('#end-date')
  $numberOfGuests = $('#number-of-guests')

  $startDate.datepicker
    dateFormat: 'yy-mm-dd'
    minDate: 0
    onSelect: ->
      minDate = $(@).datepicker('getDate')
      $endDate.datepicker('option', 'minDate', minDate)

  $endDate.datepicker
    dateFormat: 'yy-mm-dd'
    onSelect: ->
      maxDate = $(@).datepicker('getDate')
      $startDate.datepicker('option', 'maxDate', maxDate)

  $('body').on 'click', '.action .book-button', ->
    $button = $(@)
    roomId = $button.data 'room-id'
    url = $button.data 'url'
    data =
      reservation:{
        start_date: $startDate.val()
        end_date: $endDate.val()
        guests: $numberOfGuests.val()
        reservation_rooms_attributes:[
          room_id: roomId
          amount_reserved: 1
        ]
      }

    $.ajax
      url: url
      method: 'POST'
      data: data
      success: ->
        console.log 'yeah'
      error: ->
        console.log 'nah'
    return


@Form = { init }