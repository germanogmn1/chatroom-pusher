class Client
  constructor: (@nickname) ->
    
  enter: ->
    this.push "enter", nickname: @nickname
    
  exit: ->
    this.push "exit", nickname: @nickname
  
  message: (message) ->
    this.push "message", nickname: @nickname, message: message
    
  push: (event, params) ->
    $.post "push/messaging/#{event}", params

Logger =
  log: (message) ->
    $("#chat-log").append(message + "<br />")

# Pusher events
pusher = new Pusher "3c30d268802da61414b2"
channel = pusher.subscribe "messaging"

channel.bind "message", (data) ->
  Logger.log "<strong>#{data.nickname}:</strong> #{data.message}";

channel.bind "enter", (data) ->
  Logger.log "<em>* <strong>#{data.nickname}</strong> entrou</em>"

channel.bind "exit", (data) ->
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

