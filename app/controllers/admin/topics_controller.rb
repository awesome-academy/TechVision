class Admin::TopicsController < Admin::BaseController
  def index
    @topics = Topic.all.paginate(
      page: params[:page], per_page: Settings.paginate)
    @topic = Topic.new
  end

  def new
  end

  def create
    @topic = Topic.new topic_params
    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: t("index.topicCreated") }
        format.js
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @topic = Topic.find params[:id]
    if @topic.update topic_params
      flash[:success] = t("index.topicUpdated")
      respond_to do |format|
        format.html { redirect_to @topic}
        format.js
      end
    else
      flash[:success] = t("index.topicUpdate")
    end
  end

  def destroy
    @topic = Topic.find params[:id]
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: t("index.topicDestroyed")}
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  private
  def topic_params
     params.require(:topic).permit(:name)
  end
end