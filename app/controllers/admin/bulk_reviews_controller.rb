class Admin::BulkReviewsController < Admin::BaseController
  def destroy
  	 if params[:review_ids]
  	 	ids = params[:review_ids]
        Review.where(id: ids).destroy_all
        flash[:success] = t("index.Review Deleted!")
      end
      redirect_to admin_reviews_path
  end
end
