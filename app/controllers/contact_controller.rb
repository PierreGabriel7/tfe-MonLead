class ContactController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :redirect_if_logged_off

  # Send email as an manager
  def send_contact
    @town = @user.town
    @adress = @user.street.to_s + " " + @user.street_nbr.to_s
    @company = @user.company_name
    if ContactMailer.with(company_name: @company, adress: @adress, town: @town, message: params[:message], from: @current_user.email, to: params[:recipient]).contact_email.deliver_later
      flash[:success] = t("mailer.message_sent").capitalize
    else
      flash[:error] = t("mailer.message_error").capitalize
    end
    redirect_to controller: "contracts", action: "index"
  end

  # Send email as an intermediary
  def send_contact_app_aff
    @town = @user.town
    @adress = @user.street.to_s + " " + @user.street_nbr.to_s
    @app_aff = @user.firstname.to_s + " " + @user.lastname.to_s
    if ContactMailer.with(app_aff: @app_aff, adress: @adress, town: @town, message: params[:message], from: @current_user.email, to: params[:recipient]).contact_app_aff.deliver_later
      flash[:success] = t("mailer.message_sent").capitalize
    else
      flash[:error] = t("mailer.message_error").capitalize
    end
    redirect_to controller: "contracts", action: "index"
  end

  # Send email as an admin
  def send_contact_admin
    @town = @user.town
    @adress = @user.street.to_s + " " + @user.street_nbr.to_s
    @app_aff = @user.firstname.to_s + " " + @user.lastname.to_s
    if ContactMailer.with(app_aff: @app_aff, adress: @adress, town: @town, message: params[:message], from: @current_user.email, to: params[:recipient]).contact_app_aff.deliver_later
      flash[:success] = t("mailer.message_sent").capitalize
    else
      flash[:error] = t("mailer.message_error").capitalize
    end
    redirect_to controller: "contracts", action: "index"
  end
end
