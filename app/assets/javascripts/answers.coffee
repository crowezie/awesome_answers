# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#click-me").on "click", ->
    if $(@).hasClass("btn-danger")
      $(@).removeClass("btn-danger")
    else
      $(@).addClass("btn-danger")


  capEachWord = (sentence) ->
    words = sentence.split(" ")
    words = words.map (word)->
      word.charAt(0).toUpperCase() + word.slice(1)
    words.join(" ")

  $("input[type='text']").on "keyup", ->
    #  document.getElementById("text").textContent = $(@).val()
    caps = capEachWord $(@).val()
    $("#text").html caps
