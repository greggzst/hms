#= require active_admin/base

loadImagePreview = ->
  $('body').off 'change', 'form.room input.photo'
  $('body').on 'change', 'form.room input.photo', (e) ->
    $input = $(@)
    $photoPreview = $input.siblings('.inline-hints').find('img')
    file = $input[0].files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      image_base64 = e.target.result
      $photoPreview.attr('src', image_base64)
    reader.readAsDataURL(file)

initSwitch = ->
  $('.switch').click (e) ->
    $elem = $(@)
    url = $elem.data('url')
    $.ajax
      type: 'PATCH'
      url: url
      dataType: 'json'
      success: (data) ->
        if data.length > 1
          $previousPrimary = $(".switch[data-id='#{data[0].photo_id}']")
          $previousPrimary.text(data[0].label)
          $previousPrimary.removeClass('yes no')
          $previousPrimary.addClass(data[0].class)

          $elem.text data[1].label
          $elem.removeClass('yes no')
          $elem.addClass(data[1].class)
        else
          $elem.text data[0].label
          $elem.removeClass('yes no')
          $elem.addClass(data[0].class)

init = ->
  initSwitch()
  loadImagePreview()

$(document).ready ->
  init()
