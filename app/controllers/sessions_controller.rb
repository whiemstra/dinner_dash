class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      name_displayed
      if @user.admin?
        redirect_to admin_path
      else
        redirect_to items_path
      end
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "You've successfully logged out."
    redirect_to root_url
  end

  def name_displayed
    if @user.display_name.present?
      flash[:success] = "Hello, #{@user.display_name}!"
    else
      flash[:success] = "Hello, #{@user.full_name}!"
    end
  end
end
