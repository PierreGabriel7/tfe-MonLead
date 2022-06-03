class HomeController < ApplicationController
  def index
    # Check if user is logged. if not redirect to loggin page
    if @is_signed_in == true
      Rails.logger.info "logged"

      # Check type of user then redirects to corresponding controller
      if @user_type == "apporteur"
        redirect_to controller: "apporteurs", action: "index"
      elsif @user_type == "gestionnaire"
        redirect_to controller: "contracts", action: "index"
      elsif @user_type == "administrateur"
        redirect_to controller: "administrateurs", action: "index"
      end
    else
      Rails.logger.info "not logged"
      redirect_to "/home/not_logged"
    end
  end
end
