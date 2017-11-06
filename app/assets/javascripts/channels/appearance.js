
App.appearance = App.cable.subscriptions.create("AppearanceChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    $('#onlineusers').html(data['html']);
    // オンラインユーザから自分を削除
    $(`div.online > a[data-speaking-to = ${$('#chat').attr('data-user-name')}]`).parent().remove();
    //ユーザ一覧のうちオンラインのものに(online)をくっつける
    $('.all-users > a > span.display-status').remove();
    $('div.online > a').each(
      function(i, elem){
        $(`a.all-users-link[data-speaking-to =
          ${$(elem).attr('data-speaking-to')}]`).append('<span class="display-status">(online)</span>');
      }
    );
  }
});
