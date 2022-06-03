class ContractsController < ApplicationController
  before_action :redirect_if_logged_off

  require "rest-client"


  def index
    # Pagination setings
    @items_per_page = 5
    @current_page = params[:page] ? params[:page].to_i : 1

    # show leads related to the current apporteur
    if @user_type == "apporteur"
      json_response = JSON.parse(RestClient.get "50.16.0.132:8080/api/queryValidContractAppAff/" + @user.id.to_s)
      elements = JSON.parse(json_response["response"])

      # Manage pagination
      @total_pages = (elements.count / @items_per_page.to_f).ceil
      @elements_count = elements.count
      @paginated = elements.to_a.paginate(:page => @current_page, :per_page => @items_per_page)

      # Manage geocoding of leads adress to coordinates
      @leads_coordinates = []

      @paginated.each do |element|
        lead = Lead.find(element["Record"]["leadID"])
        lead_adress = lead.town + " " + lead.street + " " + lead.street_nbr.to_s
        @escaped_adress = CGI.escape(lead_adress)
        map_box_response = JSON.parse(RestClient.get "https://api.mapbox.com/geocoding/v5/mapbox.places/#{@escaped_adress}.json?access_token=#{ENV["MAPBOX_ACCES_KEY"]}")
        lat = map_box_response["features"][0]["geometry"]["coordinates"][1]
        long = map_box_response["features"][0]["geometry"]["coordinates"][0]
        @leads_coordinates.push([lat, long])
      end

      @paid_amount = 0
      @pending_amount = 0
      @total_amount = 0
      @total_comm = 0

      elements.each do |i|
        @total_amount += i["Record"]["montant"].to_i
        @total_comm += (i["Record"]["montant"].to_i / 100) * i["Record"]["comm_app_aff"].to_i
        if i["Record"]["payer"] == "true"
          @paid_amount += (i["Record"]["montant"].to_i / 100) * i["Record"]["comm_app_aff"].to_i
        end

        if i["Record"]["payer"] == "false" && i["Record"]["Retirer"] == "true"
          @pending_amount += (i["Record"]["montant"].to_i / 100) * i["Record"]["comm_app_aff"].to_i
        end
      end

      # render json: {
      #          records: @urls,
      #        }

      render :template => "contracts/index_app_aff"
    elsif @user_type == "administrateur"
      json_response = JSON.parse(RestClient.get "50.16.0.132:8080/api/queryAllContracts")
      elements = JSON.parse(json_response["response"])

      @total_pages = (elements.count / @items_per_page.to_f).ceil
      @elements_count = elements.count
      @paginated = elements.to_a.paginate(:page => @current_page, :per_page => @items_per_page)

      @leads_coordinates = []

      @paginated.each do |element|
        lead = Lead.find(element["Record"]["leadID"])
        lead_adress = lead.town + " " + lead.street + " " + lead.street_nbr.to_s
        @escaped_adress = CGI.escape(lead_adress)
        map_box_response = JSON.parse(RestClient.get "https://api.mapbox.com/geocoding/v5/mapbox.places/#{@escaped_adress}.json?access_token=#{ENV["MAPBOX_ACCES_KEY"]}")
        lat = map_box_response["features"][0]["geometry"]["coordinates"][1]
        long = map_box_response["features"][0]["geometry"]["coordinates"][0]
        @leads_coordinates.push([lat, long])
      end

      render :template => "contracts/index_admin"
    elsif @user_type == "gestionnaire"
      json_response = JSON.parse(RestClient.get "50.16.0.132:8080/api/queryAllContractByGestionnaire/" + @user.id.to_s)
      elements = JSON.parse(json_response["response"])

      @total_pages = (elements.count / @items_per_page.to_f).ceil
      @elements_count = elements.count
      @paginated = elements.to_a.paginate(:page => @current_page, :per_page => @items_per_page)

      @leads_coordinates = []

      @paginated.each do |element|
        lead = Lead.find(element["Record"]["leadID"])
        lead_adress = lead.town + " " + lead.street + " " + lead.street_nbr.to_s
        @escaped_adress = CGI.escape(lead_adress)
        map_box_response = JSON.parse(RestClient.get "https://api.mapbox.com/geocoding/v5/mapbox.places/#{@escaped_adress}.json?access_token=#{ENV["MAPBOX_ACCES_KEY"]}")
        lat = map_box_response["features"][0]["geometry"]["coordinates"][1]
        long = map_box_response["features"][0]["geometry"]["coordinates"][0]
        @leads_coordinates.push([lat, long])
      end

      # render json: {
      #   records: elements.count,
      # }

      render :template => "contracts/index_gestionnaire"
    end
  end

  def show
  end

  def pay_contract
    if RestClient.put "50.16.0.132:8080/api/setContractAsPaid/" + params["id"],
                      {}.to_json, { content_type: :json, accept: :json }
      flash[:success] = t("controller.contracts.paid").capitalize + "."
      redirect_to :action => :index
    else
      flash[:error] = t("controller.error_occured").capitalize + "."
      redirect_to :action => :index
    end
  end

  def validate_contract
    if RestClient.put "50.16.0.132:8080/api/validateContract/" + params["id"],
                      {}.to_json, { content_type: :json, accept: :json }
      flash[:success] = t("controller.contracts.validate").capitalize + "."
      redirect_to :action => :index
    else
      flash[:error] = t("controller.error_occured").capitalize + "."
      redirect_to :action => :index
    end
  end

  def claim_contract
    if RestClient.put "50.16.0.132:8080/api/setContractAsRedeemed/" + params["id"],
                      {}.to_json, { content_type: :json, accept: :json }
      flash[:success] = t("controller.contracts.claimed").capitalize + "."
      redirect_to :action => :index
    else
      flash[:error] = t("controller.error_occured").capitalize + "."
      redirect_to :action => :index
    end
  end

  def update
  end

  def create
    # Check if variable is a integer or a Float
    if params[:total].to_i.is_a? Float
      is_a_float = true
    else
      is_a_float = false
    end

    if params[:total].to_i.is_a? Integer
      is_a_int = true
    else
      is_a_int = false
    end

    if params[:comm].to_i < 0 || params[:comm].to_i > 100
      # Redirect user to previous page
      flash[:error] = t("controller.contracts.comission_err").capitalize + "."
      redirect_back(fallback_location: "/")
    elsif !is_a_float && !is_a_int
      flash[:error] = t("controller.contracts.amount_err").capitalize + "."
      redirect_back(fallback_location: "/")
    else
      gestionnaire_id = @user.id
      @gestionnaire_name = @user.company_name
      @gestionnaire_email = @user.liaison_utilisateur.email

      lead_id = params[:lead]
      lead = Lead.find(lead_id)
      @lead_name = lead.firstname.to_s + " " + lead.lastname.to_s
      @lead_email = lead.email
      @region = lead.town
      app_aff_id = lead.apporteur.id
      apporteur = Apporteur.find(app_aff_id)
      @apporteur_name = apporteur.firstname.to_s + " " + apporteur.lastname.to_s
      @apporteur_email = apporteur.liaison_utilisateur.email

      RestClient.post "50.16.0.132:8080/api/addContract/",
                      { gestionnaireID: gestionnaire_id.to_s,
                        leadID: lead_id.to_s,
                        app_AffID: app_aff_id.to_s,
                        comm_app_aff: params[:comm].to_s,
                        type: params[:category].to_s,
                        montant: params[:total].to_s,
                        region: @region.to_s,
                        commentaire: params[:commentaire].to_s,
                        valide: "false",
                        retirer: "false",
                        payer: "false" }.to_json, { content_type: :json, accept: :json }

      ContactMailer.with(
        company_name: @gestionnaire_name,
        company_email: @gestionnaire_email,
        lead_name: @lead_name,
        lead_email: @lead_email,
        apporteur_name: @apporteur_name,
        apporteur_email: @apporteur_email,
        region: @region,
        from: "MonLead",
        amount: params[:total],
        comm: params[:comm],
        type: params[:category],

      ).contract_creation_summary.deliver_later

      flash[:succes] = t("controller.contracts.created").capitalize + "."

      redirect_to :action => :index
    end
  end

  def edit
  end

  def new
    # List all categories to fill the dropdown
    @categs_array = []
    categs = Categorie.all.to_a

    @leads_array = []
    leads = Lead.all.to_a

    for a in 0..categs.count - 1
      key_categ_pair = [categs[a][:name]]
      @categs_array.push(key_categ_pair)
    end

    for a in 0..leads.count - 1
      key_lead_pair = [leads[a][:firstname] + " " + leads[a][:lastname] + " : " + leads[a][:email], leads[a][:id]]
      @leads_array.push(key_lead_pair)
      puts leads[a][:email]
    end
  end
end
