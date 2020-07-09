class Admin::ReportsController < Admin::BaseController
  def index
  	@reports = Report.all.paginate(
      page: params[:page], per_page: Settings.paginate)
    respond_to do |format|
      format.html
      format.csv { send_data @reports.to_csv, filename: "reports-#{Date.today}.csv" }
    end
  end

  def show
    @review = Review.find params[:id]
    @comments = Comment.new
    @bookmark = Bookmark.new
    @hashtags = @review.hashtags
    @comment = @review.comments.build
    render "admin/reviews/show"
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    flash[:success] = t("index.Review Deleted!")
    redirect_to admin_reports_path
  end
end
