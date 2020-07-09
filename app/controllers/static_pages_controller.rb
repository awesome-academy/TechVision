class StaticPagesController < ApplicationController
  def home
    @review_new = Review.includes(:topic, :image_attachment).approval.hot
    @recentPosts = Review.includes(:topic, :image_attachment).approval.reviewNew
    @topicNumbers = Topic.all
    @reviewTops = Review.topLikes1.approval
    @hashtags = Hashtag.all
  end

  def search
    @hashtagAll = Hashtag.all
    if params[:title]
      @reviews = Review.includes(:topic, :image_attachment).searchReview(params[:title])
      respond_to do |format|
        format.json {render json: @reviews}
      end
    elsif params[:search].blank?
      redirect_to(root_path, alert: t("index.Empty field!"))
    else
      parameter = params[:search].downcase
      @parameter = params[:search].downcase
      @reviews = Review.includes(:topic, :image_attachment).searchListReview(parameter).paginate
        :page => params[:page], :per_page => Settings.paginate
    end
  end
end

