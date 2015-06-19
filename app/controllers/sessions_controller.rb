class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Hello, #{user.display_name}!"
      if user.admin?
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
end
