# frozen_string_literal: true
class RoomsController < ApplicationController
  before_action :logged_in_user
  def show
    @messages = Message.all
    @onlineusers = Onlineuser.all
  end
end
