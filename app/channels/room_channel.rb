# frozen_string_literal: true
class RoomChannel < ApplicationCable::Channel
  def unsubscribed
  end
  def subscribed
    stream_from 'room_channel'
  end
  def send_message(data)
    message = Message.create!(message: data['message'], sender: current_user.name, receiver: 'test')
    ActionCable.server.broadcast(
      'room_channel',
      message: ApplicationController.render(
        partial: 'messages/message',
        locals: { message: message }
      ),
      sender: current_user.name,
      recever: 'test'

    )
  end
end
