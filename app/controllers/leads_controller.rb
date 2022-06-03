class LeadsController < ApplicationController
  before_action :redirect_if_logged_off

  def index
    # Pagination setings
    @items_per_page = 10
    @current_page = params[:page] ? params[:page].to_i : 1

    # show leads related to the current apporteur
    if @user_type == "apporteur"
      # Pagination management to list leads related to the current apporteur

      # Manage search results if any
      if params[:keyword]
        elements = []
        # Find all results containing given keyword (CASE SENSITIVE)
        query = Lead.where("#{params[:type]}.contains": params[:keyword]).all
        # filter the results to retrive only leads related to the current apporteur
        query.each do |lead|
          if lead["apporteur_ids"].include? @user.id
            elements << lead
          end
        end
      else
        elements = @user.leads
      end

      @total_pages = (elements.count / @items_per_page.to_f).ceil
      @elements_count = elements.count
      @paginated = elements.to_a.paginate(:page => @current_page, :per_page => @items_per_page)

      # show all leads if the user is an administrator
    elsif @user_type == "administrateur"
      # Manage search results if any
      if params[:keyword]
        elements = []
        # Find all results containing given keyword (CASE SENSITIVE)
        elements = Lead.where("#{params[:type]}.contains": params[:keyword]).all
      else
        elements = Lead.all
      end

      # Pagination management to list specified leads
      @total_pages = (elements.count / @items_per_page.to_f).ceil
      @elements_count = elements.count
      @paginated = elements.to_a.paginate(:page => @current_page, :per_page => @items_per_page)
      render :template => "leads/index_admin"
    end
  end

  def new
    @lead = Lead.new
  end

  def create
    lead = @user.leads.create
    lead.firstname = params[:lead][:firstname]
    lead.lastname = params[:lead][:lastname]
    lead.street = params[:lead][:street]
    lead.street_nbr = params[:lead][:street_nbr]
    lead.iban = params[:lead][:iban]
    lead.bic = params[:lead][:bic]
    lead.email = params[:lead][:email]
    lead.town = params[:lead][:town]

    if lead.save
      flash[:success] = lead.firstname + " " + t("controller.manager.created") + "."

      redirect_to controller: "leads", action: "index"
    else
      @manager = manager
      render :action => :edit
    end
  end

  def destroy
    lead = Lead.find(params[:id])
    lead.delete
    flash[:success] = lead.firstname + " " + t("controller.manager.deleted") + "."
    redirect_to :action => :index
  end

  def edit
    @lead = Lead.find(params[:id])
    if @user_type == "administrateur"
      render :template => "leads/admin_edit"
    end
  end

  def update
    lead = Lead.find(params[:id])
    if lead.update_attributes(post_params)
      flash[:success] = lead.firstname +" " + t("controller.manager.updated") + " (" + lead.id + ")"
      redirect_to :action => :index
    else
      @printer = printer
      render :action => :edit
    end
  end

  def post_params
    params.require(:lead).permit(:firstname, :lastname, :street, :street_nbr, :iban, :bic, :email, :town)
  end
end
