datePicker = ->
  $('input.date-picker').datepicker(
    format: 'dd.mm.yyyy'
  )
$(document).ready(datePicker)
$(document).on('page:load', datePicker)
