class GestionnairesController < ApplicationController
  before_action :redirect_if_logged_off

  def index
    # Pagination setings
    @items_per_page = 10
    @current_page = params[:page] ? params[:page].to_i : 1

    # Manage search results if any
    if params[:keyword]

      # Manually search for gestionnaires emails since "contains" querries don't work on associations
      if params[:type] == "email"
        elements = []

        # filter the results to retrive only gestionnaires where the email field contains the given keyword
        gestionnaires = Gestionnaire.all
        gestionnaires.each do |gestionnaire|
          if gestionnaire.liaison_utilisateur.email.include? params[:keyword]
            elements << gestionnaire
          end
        end
      else
        # Find all results containing given keyword (CASE SENSITIVE)
        elements = Gestionnaire.where("#{params[:type]}.contains": params[:keyword]).all
      end
    else
      elements = Gestionnaire.all
    end

    # Pagination management
    @total_pages = (elements.count / @items_per_page.to_f).ceil
    @manager_count = elements.count
    @paginated = elements.to_a.paginate(:page => @current_page, :per_page => @items_per_page)

    # redirect_to controller: "contracts", action: "index"
  end

  def show
  end

  def new
    @manager = Gestionnaire.new
  end

  def create
    manager = Gestionnaire.new(post_params)
    if manager.save
      liaison = manager.liaison_utilisateur.create
      liaison.email = params[:gestionnaire][:email_field]
      liaison.save
      flash[:success] = manager.company_name + " " + t("controller.manager.added") + "."

      # Send newsletter to all apporteurs when an apporteur is created
      ContactMailer.with(company_name: manager.company_name, from: @from).newsletter_to_apporteur.deliver_later

      redirect_to controller: "gestionnaires", action: "index"
    else
      @manager = manager
      render :action => :edit
    end
  end

  def edit
    @manager = Gestionnaire.find(params[:id])
    # render :action => :new
  end

  def update
    manager = Gestionnaire.find(params[:id])
    if manager.update_attributes(post_params)
      flash[:success] = manager.company_name + t("controller.manager.updated") + " (" + manager.id + ")"
      redirect_to :action => :index
    end
  end

  def destroy
    manager = Gestionnaire.find(params[:id])
    manager.delete
    flash[:success] = manager.company_name + " " + t("controller.manager.deleted")
    redirect_to :action => :index
  end

  def post_params
    params.require(:gestionnaire).permit(:company_name, :town, :street, :street_nbr, :iban, :bic)
  end
end
