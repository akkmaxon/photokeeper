class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comments_params)
    if @comment.save
      flash[:notice] = 'Your comment has been published'
    else
      flash[:alert] = 'My apologies, try again'
    end
    redirect_to album_photo_path(@username, @comment.photo.album, @comment.photo)
  end

  private

  def comments_params
    comment = params.require(:comment).permit(:body)
    comment.merge(photo_id: params[:photo_id], user_id: current_user.id)
  end
end
