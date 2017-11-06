# frozen_string_literal: true
class RoomsController < ApplicationController
  before_action :logged_in_user
  def show
    @messages = Message.all
    @onlineusers = Onlineuser.group(:name).where.not(name: current_user.name)
    @users = User.group(:name).where.not(name: current_user.name)
  end
  def api
    @messages = Message.where(sender: current_user.name, receiver: params['speaking-to'])
                       .or(Message.where(sender: params['speaking-to'], receiver: current_user.name))
    render(partial: 'rooms/chat_box')
  end
end
