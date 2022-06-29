class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path
  end
end