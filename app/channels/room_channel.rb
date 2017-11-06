# frozen_string_literal: true
class RoomChannel < ApplicationCable::Channel
  def unsubscribed
  end
  def subscribed
    stream_from "room_#{current_user.name}"
  end
  def send_message(data)
    return false if data['message'].empty?
    message = Message.create!(message: data['message'], sender: current_user.name, receiver: data['to'])
    message_html = ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message }
    )
    # 自分に配信
    ActionCable.server.broadcast(
      "room_#{current_user.name}",
      message: message_html,
      sender: current_user.name,
      receiver: data['to']
    )
    # 相手に配信
    ActionCable.server.broadcast(
      "room_#{data['to']}",
      message: message_html,
      sender: current_user.name,
      receiver: data['to']
    )
  end
end
