class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit]
  before_action :correct_user, only: [:edit, :update]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.html {render(partial: 'comment', locals: { comment: @comment})}
        format.js
        format.json {render json: {result: "OK"} }
      end
    end
  end

  def edit
    @comment = Comment.find params[:id]
    @review = Review.find params[:review_id]
  end

  def update
    @comment = Comment.find params[:id]
    if @comment.update comment_params
      flash[:success] = t("index.comment_updated")
      redirect_to review_path(params[:review_id])
    else
      @comment = Comment.find params[:id]
      @review = Review.find(params[:review_id])
      render :edit
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to @review if @comment.nil?
    flash[:success] = t("index.Comment deleted")
    redirect_to review_path(params[:review_id])
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :review_id)
  end

  def correct_user
    @comment = current_user.comments.find params[:id]
  end
end
