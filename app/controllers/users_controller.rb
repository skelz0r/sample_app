class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:notice] = "Welcome, #{@user.name}! Your registration has been successful."
      redirect_to root_path
    else
      @title = "Sign up"
      flash[:alert] = "Error. Registration failed"
      redirect_to signup_path
    end
  end
end
