class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to users_path, notice: "Succesfully Logged in!"
    else
      redirect_to login_path, alert: "Email or Password invalid!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path
  end
end