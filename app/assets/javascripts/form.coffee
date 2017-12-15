init = ->
  $startDate = $('#start-date')
  $endDate = $('#end-date')

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

@Form = { init }