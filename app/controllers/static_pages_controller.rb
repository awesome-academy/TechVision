class StaticPagesController < ApplicationController
  def home
    @review_new = Review.approval.hot
    @recentPosts = Review.approval.reviewNew
    @topicNumbers = Topic.all
    @reviewTops = Review.topLikes1.approval
    @hashtags = Hashtag.all
  end

  def search
    @hashtagAll = Hashtag.all
    if params[:title]
      @reviews = Review.searchReview(params[:title])
      respond_to do |format|
        format.json {render json: @reviews}
      end
    elsif params[:search].blank?
      redirect_to(root_path, alert: t("index.Empty field!"))
    else
      parameter = params[:search].downcase
      @parameter = params[:search].downcase
      @reviews = Review.searchListReview(parameter).paginate(
        :page => params[:page], :per_page => Settings.paginate)
    end
  end
end

