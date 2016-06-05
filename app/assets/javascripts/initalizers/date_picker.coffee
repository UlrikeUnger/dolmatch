datePicker = ->
  $('input.date-picker').datepicker()
$(document).ready(datePicker)
$(document).on('page:load', datePicker)
