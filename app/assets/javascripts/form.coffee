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

  $('body').on 'submit', '#filter-form', ->
    $form = $(@)
    formData = $form.serializeArray()
    $rooms = $('#rooms')
    $spinner = $('#spinner')
    $spinner.removeClass('hidden')
    $rooms.empty()

    $.ajax
      url: $form.attr('action')
      method: $form.attr('method')
      data: formData
      success: (data, status, jqXHR) ->
        $spinner.addClass('hidden')
        $rooms.append(data)
    false

  $('body').on 'click', '#add_service .service-amount .amount-control', ->
    $button = $(@)
    $amountInput = $button.siblings '.amount-input'
    $amountToPayInput = $('#reservation_amount_to_pay')
    $roomPriceInputs = $button.parent().parent().siblings('.room-price')

    roomPrice = parseFloat($roomPriceInputs.val())
    servicePrice = parseFloat($button.siblings('.service-price').val())
    currentAmmount = parseFloat($amountInput.val())

    if $button.hasClass 'control-increase'
      newAmount = currentAmmount + 1
      $buttonDecrease = $button.siblings('.control-decrease')
      $buttonDecrease.prop('disabled', false) if $buttonDecrease.prop('disabled')
    else
      newAmount = currentAmmount - 1
      # decrese button
      $button.prop('disabled', true) if newAmount == 0

    $amountInput.val(newAmount)

    newAmountToPay = roomPrice + newAmount * servicePrice
    $amountToPayInput.val(newAmountToPay)


  $('body').on 'click', '.action .book-button', ->
    $button = $(@)
    roomId = $button.data 'room-id'
    roomPrice = $button.data 'room-price'
    url = $button.data 'url'
    data =
      reservation:{
        start_date: $startDate.val()
        end_date: $endDate.val()
        amount_to_pay: roomPrice
        reservation_rooms_attributes:[
          room_id: roomId
          amount_reserved: 1
          guests: $numberOfGuests.val()
          room_price: roomPrice
        ]
      }

    $.ajax
      url: url
      method: 'POST'
      data: data
      success: (data, status, jqXHR) ->
        $('#add-services').empty()
        $('#add-services').append(data)
        $('#add-services-tab').parent().removeClass 'disabled'
        $('#add-services-tab').trigger 'click'

    return

  $('body').on 'submit', '#add_service', ->
    $form = $(@)
    formData = $form.serializeArray()

    console.log formData

    $.ajax
      url: $form.attr('action')
      method: $form.attr('method')
      data: formData
      success: (data, status, jqXHR) ->
        $('#book-and-confirm').empty()
        $('#book-and-confirm').append(data)
        $('#book-and-confirm-tab').parent().removeClass 'disabled'
        $('#book-and-confirm-tab').trigger 'click'
      error: (jqXHR, status, error) ->
    #prevents form from submission
    false

  $('body').on 'change', '#reservation-step-3 #reservation_user_attributes_has_account', ->
    $form = $(@).closest 'form'
    if $(@).is(':checked')
      $hiddenFields = $form.find '.hidden'
      $hiddenFields.removeClass 'hidden'
      $hiddenFields.addClass 'shown'
    else
      $shownFields = $form.find '.shown'
      $shownFields.removeClass 'shown'
      $shownFields.addClass 'hidden'

  $('body').on 'submit', '#new_reservation', ->
    $form = $(@)
    formData = $form.serializeArray()

    $.ajax
      url: $form.attr('action')
      method: $form.attr('method')
      data: formData
      success: (data, status, jqXHR) ->
        console.log 'supper'
      error:(jqXHR, status, error) ->
        $form.replaceWith(jqXHR.responseText)
    #prevents form from submission
    false


@Form = { init }