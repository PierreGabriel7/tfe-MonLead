class LiaisonUtilisateursController < ApplicationController
  before_action :redirect_if_logged_off

  def new
    @liaison = LiaisonUtilisateur.new
  end

  def index
    @liaison = LiaisonUtilisateur.all
  end

  def create
    @liaison = LiaisonUtilisateur.new(post_params)
    if @liaison.save
      flash[:succes] = @liaison.email +" " + t("controller.manager.added") + "."
      redirect_to action: :index
    else
      flash[:error] = t("controller.error_occured") + "."
      # @printer = printer
      # render action: :edit
    end
  end

  def post_params
    params.require(:liaison_utilisateur).permit(:email)
  end
end
