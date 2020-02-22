# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      remember_or_forget user
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combo'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def remember_or_forget(user)
    params[:session][:remember] == '1' ? remember(user) : forget(user)
  end
end
