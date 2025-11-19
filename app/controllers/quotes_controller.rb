class QuotesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  # GET /quotes or /quotes.json
  def index
    @quotes = current_user.quotes
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @quote.build_author
    15.times { @quote.quote_categories.build }
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = current_user.quotes.new(quote_params)
    
    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        # Rebuild the form if validation fails
        @quote.build_author unless @quote.author
        (15 - @quote.quote_categories.size).times { @quote.quote_categories.build }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: "Quote was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy!
    
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Authorization: only allow users to edit/update/destroy their own quotes
    # Unless they're an admin
    def authorize_user
      unless @quote.user_id == current_user.id || current_user.is_admin?
        redirect_to quotes_path, alert: "You are not authorized to perform this action."
      end
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(
        :text,
        :publication_year,
        :user_comment,
        :is_public,
        :user_id,
        author_attributes: [:id, :fname, :lname, :birth_year, :death_year, :biography],
        quote_categories_attributes: [:id, :quote_id, :category_id, :_destroy]
      )
    end
end