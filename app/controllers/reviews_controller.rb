class ReviewsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :edit]
  before_action :admin_user, only: :destroy

  def index
    @reviews = Review.all_review
  end

  def show
    @review = Review.find params[:id]
    @bookmark = Bookmark.new
    @report = Report.new
    if logged_in?
      @bookmarked = Bookmark.bookmarked(@review.id, current_user.id).first
      @reported = Report.reported(@review.id, current_user.id).first
    end
    @comments = @review.comments.comment_time.paginate(page: params[:page], per_page: 5)
    @comment = @review.comments.build
    @hashtags = @review.hashtags
    @reviewFilter = Review.reviewHashtag params[:id]
    unless @review.appended
      redirect_to root_path
    end
  end

  def new
    @review = Review.new
    @topics = Topic.all
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.image.attach params[:review][:image]
    if @review.save
      flash[:success] = t("index.Review created!")
      redirect_to @review
    else
      @topics = Topic.all
      render :new
    end
  end

  def edit
    @review = Review.find params[:id]
    @topics = Topic.all
    @hashtags = @review.hashtags
  end

  def update
    @review = Review.find params[:id]
    if @review.update review_params
      flash[:success] = t("index.Review updated")
      redirect_to @review
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    flash[:success] = t("index.Review Deleted!")
    redirect_to user_path(current_user)
  end

  private
  def review_params
    params.require(:review).permit :id, :content, :image,
     :title, :topic_id, hashtag_details_attributes:
     [:id, :hashtag_id, :_destroy, hashtag_attributes: [:name]]
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
