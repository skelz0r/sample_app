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
      redirect_to root_path
    else
      @title = "Sign up"
      @error = true
      render 'new'
      end
  end
end
