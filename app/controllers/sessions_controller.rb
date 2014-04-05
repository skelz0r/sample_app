class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      @title = "Sign up"
      flash[:alert] = "Wrong email/password."
      redirect_to signin_path
    else
      flash[:notice] = "Welcome back, #{user.name}!"
      redirect_to root_path
    end
  end
end

def destroy
end
