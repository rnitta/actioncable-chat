# frozen_string_literal: true
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      cookies.signed[:name] = user.name
      redirect_to '/'
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
