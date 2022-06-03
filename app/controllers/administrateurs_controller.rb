class AdministrateursController < ApplicationController
  before_action :redirect_if_logged_off

  def index
    redirect_to controller: "contracts", action: "index"
  end
end
