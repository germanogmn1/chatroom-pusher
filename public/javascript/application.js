var pusher = new Pusher('3c30d268802da61414b2');
var channel = pusher.subscribe('messaging');

channel.bind('new_message', function(data) {
  var message = "<b>" + data.nickname + ":</b> " + data.message + "\n";
  
  $("#chat-log").append(message);
});

$(document).ready(function() {
  do {
    var nickname = prompt("Escolha um nickname");
  } while (!nickname.length)
  
  $("#message-form").submit(function() {
    var input = $(this).find("input[type=text]");
    var message = input.val();
    input.val(""); // clear input
    
    $.post($(this).attr("action"), {
      nickname: nickname,
      message: message,
    });
    
    return false;
  });
});
