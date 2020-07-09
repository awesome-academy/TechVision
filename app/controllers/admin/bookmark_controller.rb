class Admin::BookmarksController < Admin::BaseController
  def index
    @bookmarks = Bookmark.all
    respond_to do |format|
      format.html
      format.csv { send_data @bookmarks.to_csv, filename: "bookmarks-#{Date.today}.csv" }
    end
  end
end