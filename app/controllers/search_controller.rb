class SearchController < ApplicationController

  def index
    # Get the search term from the URL parameters
    category_query = params[:category_query]
      if category_query.present?
        @quotematch = Quote.joins(:quote_categories,
        :categories).where("categories.name LIKE ?", "%#{category_query}%").distinct
    end
  end
end
