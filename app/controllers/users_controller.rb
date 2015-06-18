class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) # -- create private user_params method
    if @user.save
      session[:user_id] = @user.id # -- had created a user, we're now taking their id and storing it in the session
      redirect_to items_path # -- could do: user_path(user), but system defaults to show, so user would work
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:full_name, :display_name, :email, :password)  #display name is optional
  end
end
