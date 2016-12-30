class SearchController < InternalPagesController
  def index
    @search_results = Search.all(params[:q])
  end

  def submissions
    @submissions = Search.submissions(params[:q])
    respond_to do |format|
      format.js
    end
  end
end
