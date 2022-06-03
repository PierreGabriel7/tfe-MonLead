require "cognito_jwt_keys"

require "cognito_client"

class ApplicationController < ActionController::Base
  before_action :check_signed_in
  before_action :set_locale

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def check_signed_in
    @is_signed_in = false
    @current_user = nil
    @cognito_session = nil

    cognito_session = nil

    # If user is logged in
    if session[:cognito_session_id]
      begin
        cognito_session = CognitoSession.find(session[:cognito_session_id])
      rescue ActiveRecord::RecordNotFound
      end

      # If user not logged in then
    else
      # redirect_to controller: "home", action: "index"
      # redirect_to "/home/not_logged"

      # return
    end

    return unless cognito_session

    now = Time.now.tv_sec

    if cognito_session.expire_time > now
      # Still valid, use
      #
      Rails.logger.info("Found a non-expired cognito session: #{cognito_session.id}")
      @is_signed_in = true
      @current_user = cognito_session.user
      @cognito_session = cognito_session

      # If user is logged in then
      user_email = @current_user.email

      # If logged user is a new user then create a link table between user and apporteur
      if LiaisonUtilisateur.where(email: @current_user.email).first == nil
        app = Apporteur.new(
          total_earnings: "0",
          reedeemed_earning: "0",
          current_earnings: "0",
        )
        app.save
        liaison = app.liaison_utilisateur.create
        liaison.email = user_email
        liaison.save
      end

      # Asigns the logged email to the link table
      logged_user = LiaisonUtilisateur.where(email: @current_user.email).first

      # Check if user has a custom avatar if not set default
      @profile_picture_url = ""
      if File.exists?(File.join(Rails.public_path, "uploads", "#{@current_user.email}.png"))
        Rails.logger.info "File exists"
        @profile_picture_url = "/uploads/#{@current_user.email}.png"
      elsif File.exists?(File.join(Rails.public_path, "uploads", "#{@current_user.email}.jpg"))
        @profile_picture_url = "/uploads/#{@current_user.email}.jpg"
      elsif Rails.logger.info "File does not exist"
        @profile_picture_url = "user-solid.svg"
      end

      # Check if user is an apporteur
      if logged_user.apporteur_ids != nil
        @user = logged_user.apporteur
        @user_type = "apporteur"
        @title = t("user_types.intermediary").capitalize
        Rails.logger.info "User is an apporteur"

        # check if user is an admin
      elsif logged_user.administrateur_ids != nil
        @user = logged_user.administrateur
        @user_type = "administrateur"
        @title = t("user_types.admin").capitalize
        Rails.logger.info "User is an admin"

        # Check if user is a gestionnaire
      elsif logged_user.gestionnaire_ids != nil
        @user = logged_user.gestionnaire
        @user_type = "gestionnaire"
        @title = t("user_types.manager").capitalize
        Rails.logger.info "User is a gestionnaire"
      end

      return
    end

    Rails.logger.info("Refreshing cognito session: #{cognito_session.id}")
    # Need to refresh token

    if refresh_cognito_session(cognito_session)
      @is_signed_in = true
      @current_user = cognito_session.user
      @cognito_session = cognito_session
      nil
    end
  end

  def refresh_cognito_session(cognito_session)
    client = new_cognito_client

    resp = client.refresh_id_token(cognito_session.refresh_token)

    return false unless resp

    cognito_session.expire_time = resp.id_token[:exp]
    cognito_session.issued_time = resp.id_token[:auth_time]
    cognito_session.audience = resp.id_token[:aud]

    cognito_session.save!
  end

  def new_cognito_client
    CognitoClient.new(redirect_uri: auth_sign_in_url)
  end

  def redirect_if_logged_off
    if @is_signed_in != true
      redirect_to controller: "home", action: "index"
    end
  end
end
