#= require active_admin/base

loadImagePreview = ->
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
    elem = $(@)
    url = elem.data('url')
    $.ajax
      type: 'PATCH'
      url: url
      dataType: 'json'
      success: (data) ->
        elem.text data.label
        elem.removeClass('yes no')
        elem.addClass(data.class)

init = ->
  initSwitch()
  loadImagePreview()

$(document).ready ->
  init()
