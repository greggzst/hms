initIndex = ->
  $('.reservation-show-link').click (e) ->
    e.preventDefault()
    $link = $(@)
    url = $link.data 'url'
    $.ajax
      url: url
      success: (data, status, jqXHR) ->
        $reservationModal = $('#reservations_modal')
        $modalContent = $reservationModal.find '.modal-body'
        $modalContent.empty().append(data)
        $('#reservations_modal').modal()
      error: (jqXHR, status, error) ->
        alert(error)

@Reservations = { initIndex }