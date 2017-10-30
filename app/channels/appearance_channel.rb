# frozen_string_literal: true
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearance_channel'
    ActionCable.server.broadcast(
      'appearance_channel',
      action: 'come',
      name: current_user.name
    )
    Onlineuser.create(name: current_user.name)
  end

  def unsubscribed
    ActionCable.server.broadcast(
      'appearance_channel',
      action: 'go',
      name: current_user.name
    )
    Onlineuser.find_by(name: current_user.name).destroy
  end
end
