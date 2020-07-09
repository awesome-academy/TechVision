class BookmarksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @user = current_user
    @bookmarks = @user.bookmarks.paginate(
      page: params[:page], per_page: Settings.paginate)
  end

  def create
    @bookmark = current_user.bookmarks.build bookmark_params
    if @bookmark.save
      respond_to do |format|
      format.html { redirect_to @review }
      format.js
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find params[:id]
    @bookmark.destroy
    flash[:success] = t("index.Bookmark deleted!")
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit :review_id
  end

  def correct_user
    @bookmark = current_user.bookmarks.find params[:id]
    redirect_to root_url if @bookmark.nil?
  end
end
