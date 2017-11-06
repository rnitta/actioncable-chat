user_name_low = $('div#chat').attr('data-user-name').toLowerCase();
user_name = user_name_low.charAt(0).toUpperCase() + user_name_low.slice(1);
App.room = App.cable.subscriptions.create({
  channel: "RoomChannel",
  room: user_name
}, {
  connected: function() {}, //接続時
  disconnected: function() {}, //切断時
  received: function(data) { //受信時
    $('#messages').append(data['message']);
    if(data['sender'] != $('div#chat').attr('data-user-name') &&
        data['sender'] != $('div#chat').attr('data-speaking-to')){
          $('div#onlineusers a').attr('data-speaking-to', data['sender']).append('<span class="notify"> ( ! )</span>');
        }
  },
  send_message: function(message) { //送信時
    this.perform('send_message', {
      message: message,
      to: $('div#chat').attr('data-speaking-to')
    });
  }
}, $(document).on('keypress', '[data-behavior=message_sender]', function(event) {　
  if (event.keyCode === 13) { //enterキー押下イベントを取得
    if (event.target.value != '') { //フォームが空じゃない場合のみ送信
      App.room.send_message(event.target.value);
    }
    event.target.value = '';
    event.preventDefault();
  }
}));

//チャット相手切り替え
$(document).on('click', 'a.switch-user', function() {
  $('div#chat').attr('data-speaking-to', $(this).attr('data-speaking-to'));
  $('div#chat').html(''); //一回空にする
  $.ajax({
      url: '/api/chat_box',
      type: 'GET',
      data: {
        'speaking-to': $('div#chat').attr('data-speaking-to')
      }
    })
    .done(function(data) {
      $('div#chat').html(data);
    })
    .fail(function() {
      alert('error');
    });

});
