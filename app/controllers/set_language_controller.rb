class SetLanguageController < ApplicationController
  before_action :redirect_if_logged_off

  def fr
    I18n.locale = :fr
    set_session_and_redirect
  end

  def en
    I18n.locale = :en
    set_session_and_redirect
  end

  private

  def set_session_and_redirect
    session[:locale] = I18n.locale
    redirect_back(fallback_location: root_path)
  end
end
