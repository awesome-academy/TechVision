class HashtagsController < ApplicationController
  def index
    @hashtags = Hashtag.searchHashtag params[:name]
    respond_to do |format|
      format.json {
        render json: @hashtags
      }
    end
  end

  def show
    @hashtag = Hashtag.find params[:id]
    @reviews = @hashtag.reviews.includes(:topic, :image_attachment).approval.paginate
     :page => params[:page], :per_page => Settings.paginate
    @hashtagAll = Hashtag.all
  end
end



