class SearchController < ApplicationController
  def index
    @pages = PageSearch.search(params)
    @term = params[:term] if params[:term].present?
  end
end
