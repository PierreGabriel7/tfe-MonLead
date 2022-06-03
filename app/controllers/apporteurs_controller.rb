class ApporteursController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :redirect_if_logged_off


  def complete_account_update
    app_aff = Apporteur.find(params[:id])
    if app_aff.update_attributes(post_params)
      flash[:notice] = t("controller.apporteurs.account_saved").capitalize
      redirect_to :action => :index
    else
      @app_aff = app_aff
      render :action => :complete_account_edit
    end
  end

  def complete_account_edit
    @app_aff = Apporteur.find(params[:id])

    render :template => "apporteurs/complete_account"
    # render :action => :new
  end

  def index
    @leadlist = Apporteur.all
    # If apporteur has not completed his profile redirect to profile edition page.
    if @user.iban == nil
      # flash[:notice] ='Veuillez completer vos informations'
      redirect_to controller: "apporteurs", action: "complete_account_edit", id: @user.id
      return
    end
    redirect_to controller: "contracts", action: "index"
  end

  def show
    @apporteur = Apporteur.find(params[:id])
    puts(@apporteur.firstname)
  end

  def new
    @apporteur = Apporteur.new
  end

  def create
    @apporteur = Apporteur.new(post_params)
    @apporteur.save
  end

  def update
    app_aff = Apporteur.find(params[:id])
    if app_aff.update_attributes(post_params)
      flash[:success] = app_aff.lastname + t("controller.apporteurs.account_saved") + " (" + app_aff.id + ")"
      # redirect_to :action => :index
    else
      @app_aff = app_aff
      render :action => :edit
    end
  end

  def edit
    @app_aff = Apporteur.find(params[:id])

    render :action => :new
  end

  def complete_app_aff
    app_aff = Apporteur.find(params[:id])
    # app_aff.update_attributes(post_params)
  end

  def post_params
    params.require(:apporteur).permit(:firstname, :lastname, :town, :street, :street_nbr, :iban, :bic)
  end
end
