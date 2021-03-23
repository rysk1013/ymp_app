class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.includes(:user).order(created_at: :desc)
  end
end