class UsersController < ApplicationController
  before_action :redirect_if_logged_off

  def index
  end

  def show
    if @user_type == "apporteur"
      render :template => "users/show_apporteur"
    elsif @user_type == "administrateur"
      render :template => "users/show_admin"
    elsif @user_type == "gestionnaire"
      render :template => "users/show_gestionnaire"
    end
  end

  def edit
    if @user_type == "apporteur"
      render :template => "users/apporteur_edit"
    elsif @user_type == "administrateur"
      render :template => "users/admin_edit"
    elsif @user_type == "gestionnaire"
      render :template => "users/gestionnaire_edit"
    end
  end

  def update
    user = @user
    if @user_type == "apporteur"
      if user.update_attributes(firstname: params[:firstname], lastname: params[:lastname], street: params[:street], street_nbr: params[:street_nbr], town: params[:town], iban: params[:iban], bic: params[:bic])
        flash[:success] = t("controller.user.updated").capitalize + "."
      else
        flash[:error] = t("controller.error_occured").capitalize + "."
      end
    elsif @user_type == "administrateur"
      if user.update_attributes(firstname: params[:firstname], lastname: params[:lastname], street: params[:street], street_nbr: params[:street_nbr], town: params[:town])
        flash[:success] = t("controller.user.updated").capitalize + "."
      else
        flash[:error] = t("controller.error_occured").capitalize + "."
      end
    elsif @user_type == "gestionnaire"
      if user.update_attributes(company_name: params[:company_name], street: params[:street], street_nbr: params[:street_nbr], town: params[:town], iban: params[:iban], bic: params[:bic])
        flash[:success] = t("controller.user.updated").capitalize + "."
      else
        flash[:error] = t("controller.error_occured").capitalize + "."
      end
    end

    # render json: {
    #          records: params,
    #        }

    redirect_to "/users/show"
  end
end
