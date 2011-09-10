class Client
  constructor: (@nickname) ->
    
  enter: ->
    $.post "client_in", nickname: @nickname
    
  exit: ->
    $.post "client_out", nickname: @nickname
  
  message: (message) ->
    $.post "new_message", nickname: @nickname, message: message

Logger =
  log: (message) ->
    $("#chat-log").append(message + "\n")

# Pusher events
pusher = new Pusher "3c30d268802da61414b2"
channel = pusher.subscribe "messaging"

channel.bind "new_message", (data) ->
  Logger.log "<strong>#{data.nickname}:</strong> #{data.message}";

channel.bind "client_in", (data) ->
  Logger.log "<em>* <strong>#{data.nickname}</strong> entrou</em>"

channel.bind "client_out", (data) ->
  Logger.log "<em>* <strong>#{data.nickname}</strong> saiu</em>"


$(document).ready ->
  nickname = prompt "Escolha um nickname" until nickname
  
  client = new Client(nickname)
  client.enter()
  
  $("#message-form").submit ->
    input = $(this).find "input[type=text]"
    message = input.val()
    input.val "" # clear input
    client.message(message)
    false
  
  $(window).unload ->
    client.exit()

