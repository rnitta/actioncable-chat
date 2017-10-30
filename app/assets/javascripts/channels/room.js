App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {}, //接続時
  disconnected: function() {}, //切断時
  received: function(data) { //受信時
    $('#messages').append(data['message']);
  },
  send_message: function(message) { //送信時
  this.perform('send_message', {
      message: message
    });
  }
}, $(document).on('keypress', '[data-behavior~=message_sender]', function(event) {　
  if (event.keyCode === 13) { //enterキー押下イベントを取得
    App.room.send_message(event.target.value);
    event.target.value = '';
    event.preventDefault();
  }
}));
