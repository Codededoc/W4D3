class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
    # what we want here is to ensure that if user is logged in, they're using the same
    # session token
    # if not logged in, redirect to new_session_token
  end

  def log_in!(user)
    # if user
      session[:session_token] = user.reset_session_token!
    # redirect_to cats_url
    # else
    #   flash.now[:errors] = ['Invalid username or password']
    #   render :new
    # end
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
        flash[:error] = "You must be logged in"
        redirect_to users_url
end
