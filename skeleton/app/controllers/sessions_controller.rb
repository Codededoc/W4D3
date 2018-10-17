class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username]
      params[:user][:password]
    )
    if user
      log_in!(user)
      redirect_to cats_url
    else
      flash.now[:errors] = ['Invalid username or password']
      render :new
    end

  end

  def destroy
    log_out!
    # current_user.reset_session_token!
    # session[:session_token] = nil
    # redirect_to new_session_url
  end

end
