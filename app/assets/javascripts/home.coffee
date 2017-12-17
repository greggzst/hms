init = ->

  $('#drawer-button').on 'click', (e) ->
    $attachTo = $('#attach-filter')
    url = $(@).data 'url'

    $.ajax
      url: url
      success: (data, status, jqXHR) ->
        $attachTo.append(data)
        $attachTo.parent().addClass('visible')


@Home = { init }