$ ->
  $("#add_file").on "ajax:success", (event, data) ->
    $("#assets").append data
  $("#add_file").on "ajax:before", (event) ->
    $(event.target).data "params", { index: $('#assets div.file').length }

# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
