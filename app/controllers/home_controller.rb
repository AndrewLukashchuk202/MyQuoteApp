class HomeController < ApplicationController
    # Displays 10 recently public added quotes to the main home page
    def index
        @quotes = Quote.where(is_public: true)
                   .order(created_at: :desc)
                   .limit(10)
                   .includes(:author, :user, :categories)
    end

    # Displays all quotes belonging to the current logged-in user
    def uquotes
        @quotes = Quote.includes(:categories).where(user_id: session[:user_id])
    end
end
