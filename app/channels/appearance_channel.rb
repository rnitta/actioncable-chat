# frozen_string_literal: true
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearance_channel'
    Onlineuser.create(name: current_user.name)
    broadcast_updates
  end

  def unsubscribed
    Onlineuser.find_by(name: current_user.name).destroy
    broadcast_updates
  end

  private

  def broadcast_updates
    onlines_html = ApplicationController.render(partial: 'users/onlineuser',
                                                collection: Onlineuser.group(:name))
    ActionCable.server.broadcast(
      'appearance_channel',
      html: onlines_html
    )
  end
end
