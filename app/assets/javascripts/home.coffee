init = ->

  $('body').on 'input', '.has-error input', ->
    $(@).parent().removeClass 'has-error'
    $(@).next('.help-block').remove()

  $('#drawer-button').on 'click', (e) ->
    $attachTo = $('#attach-filter')
    url = $(@).data 'url'

    $.ajax
      url: url
      success: (data, status, jqXHR) ->
        $attachTo.empty()
        $attachTo.append(data)
        $attachTo.parent().addClass('visible')

  $(document).click (e) ->
    if !$(e.target).closest('.home-book').length
      $('.home-book').removeClass 'visible' if $('.home-book').hasClass 'visible'


@Home = { init }