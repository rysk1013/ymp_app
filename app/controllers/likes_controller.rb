class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_already_like

  def create
      @like = Like.create(post_id: params[:post_id], user_id: current_user.id)
      redirect_back(fallback_location: root_path)
  end

  def destroy
    @already_like.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_already_like
    @already_like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
  end
end
