class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

private
  def user_params
    params.require(:user).permit(:username, :password)
                  # permits whatever was entered on the form,
                  # to be passed to the model to be validated,
                  # in order for a user object to be created
  end
end
