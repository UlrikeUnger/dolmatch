initLanguageSelect = ->
  $('.language-select').find('select').on 'change', (e)->
    e.target.closest('form').submit()

$(document).ready(initLanguageSelect)
$(document).on('page:load', initLanguageSelect)
