class Admin::ReviewsController < Admin::BaseController
  before_action :admin_user, only: :destroy

  def index
    @reviews = Review.all_review.paginate(
      page: params[:page], per_page: Settings.paginate)
  end

  def show
    @review = Review.find params[:id]
    @bookmark = Bookmark.new
    @comments = @review.comments.paginate(
      :page => params[:page], :per_page => Settings.comments)
    @comment = @review.comments.build
    @hashtags = @review.hashtags
    @reviewFilter = Review.reviewHashtag(params[:id])
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
    redirect_to admin_reviews_path
  end

  private

  def review_params
    params.require(:review).permit :content, :title, :topic_id, hashtag_ids:[]
  end

  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    redirect_to root_url if @review.nil?
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
