class LeadsController < ApplicationController
  before_action :set_lead, only: %i[ show edit update destroy ]
  require 'zendesk_api'
  require 'sendgrid-ruby'
  include SendGrid
  require 'json'

  
  # GET /leads or /leads.json
  def index
    @leads = Lead.all
  end

  # GET /leads/1 or /leads/1.json
  def show
  end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit
  end


  # POST /leads or /leads.json
  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if @lead.save
        format.html { redirect_to @lead, notice: "Lead was successfully created." }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
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
    ZendeskAPI::Ticket.create!(client, :type => "question", :subject => " #{@lead.full_name_contact} from #{@lead.company_name}", :comment => { :value =>
      "The contact #{@lead.full_name_contact} from company from #{@lead.company_name} can be reached at email #{@lead.email} and at phone number #{@lead.phone}. #{@lead.department} has a project named #{@lead.project_name} which would require contribution from Rocket Elevators. 
      #{@lead.project_description}
      Attached Message: #{@lead.message}
      The Contact uploaded an attachment"
      
      }, :submitter_id => current_user.id, :priority => "urgent")
    # ZendeskAPI::Ticket.find!(client, :id => 1)
    # ZendeskAPI::Ticket.destroy!(client, :id => 1)



    #Sends an email when it is saved to whoever filled out the contact us form

    puts 'sendgrid'

    from = Email.new(email: 'apexrocketelevators@gmail.com')
    subject = 'Thank you for contacting us!'
    to = Email.new(email: @lead.email)
    content = Content.new(type: 'text/html', value: 'some text here')
    mail = SendGrid::Mail.new(from, subject, to, content)

    contactemail = Personalization.new
    contactemail.add_to(Email.new(email: @lead.email))
    contactemail.add_dynamic_template_data({
      "full_name" => @lead.full_name_contact,
      "project_name" => @lead.project_name
    })
    mail.add_personalization(contactemail)
    mail.template_id = 'd-41b5591acb6a41ae9989d1363275aa5a'

    # puts JSON.pretty_generate(mail.to_jso
    puts mail.to_json
  
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

  # PATCH/PUT /leads/1 or /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to @lead, notice: "Lead was successfully updated." }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1 or /leads/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: "Lead was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lead_params
      params.permit(:full_name_contact, :company_name, :email, :phone, :project_name, :project_description, :department, :message, :file, :request_date)
    end
end
