initTooltip = ->
  $("[data-toggle='tooltip']").tooltip()

$(document).ready(initTooltip)
$(document).on('page:load', initTooltip)
