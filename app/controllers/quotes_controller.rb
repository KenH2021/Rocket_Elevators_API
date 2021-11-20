class QuotesController < ApplicationController
  # before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  require 'zendesk_api'

  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    
    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end

    client = ZendeskAPI::Client.new do |config|
      # Mandatory:
    
      config.url = "https://apexrockets.zendesk.com/api/v2" # e.g. https://yoursubdomain.zendesk.com/api/v2
    
      # Basic / Token Authentication
      config.username = "apexrocketelevators@gmail.com"
    
      # Choose one of the following depending on your authentication choice
      # config.token = ENV['ZENDESK_CONFIG_TOKEN']
      config.password = ENV['ZENDESK_PASSWORD']
    
      # # OAuth Authentication
      # config.access_token = ENV['ZENDESK_ACCESS_TOKEN']

      # Optional:
    
      # Retry uses middleware to notify the user
      # when hitting the rate limit, sleep automatically,
      # then retry the request.
      config.retry = true
    
      # Raise error when hitting the rate limit.
      # This is ignored and always set to false when `retry` is enabled.
      # Disabled by default.
      config.raise_error_when_rate_limited = false
    
      # Logger prints to STDERR by default, to e.g. print to stdout:
      require 'logger'
      config.logger = Logger.new(STDOUT)
    
      # Disable resource cache (this is enabled by default)
      config.use_resource_cache = false
    
      # Changes Faraday adapter
      # config.adapter = :patron
    
      # Merged with the default client options hash
      # config.client_options = {:ssl => {:verify => false}, :request => {:timeout => 30}}
    
      # When getting the error 'hostname does not match the server certificate'
      # use the API at https://yoursubdomain.zendesk.com/api/v2
    
      # Change retry configuration (this is disabled by default)
      config.retry_on_exception = true
    
      # Error codes when the request will be automatically retried. Defaults to 429, 503
      config.retry_codes = [ 429 ]
    end
    
    ZendeskAPI::Ticket.new(client, :id => 1, :priority => "urgent") # doesn't actually send a request, must explicitly call #save!
    ZendeskAPI::Ticket.create!(client, :type => "task", :subject => " The company #{@quote.company_name}", :comment => { :value =>
        "The company #{@quote.company_name} has made a quote for a building of type #{@quote.building_type} and wants the #{@quote.type_of_service} service. 
          Quote information: 
          Amount of elevators needed: #{@quote.amount_of_elevator}
          Price per elevator: #{@quote.price_per_elevator}
          Total price of the elevators: #{@quote.total_price_of_elevator}
          Installation price: #{@quote.installation}
          Total price: #{@quote.total_price}
          The company #{@quote.company_name} can be reached at #{@quote.company_email}."
    
          }, :submitter_id => current_user.id, :priority => "urgent")
    # ZendeskAPI::Ticket.find!(client, :id => 1)
    # ZendeskAPI::Ticket.destroy!(client, :id => 1)

  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:amount_of_elevator, :price_per_elevator, :total_price_of_elevator, :installation, :total_price, :building_type, :user_id, :company_name, :company_email, :type_of_service)
    end
end


