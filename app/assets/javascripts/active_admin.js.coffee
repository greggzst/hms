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

$(document).ready ->
  loadImagePreview()
