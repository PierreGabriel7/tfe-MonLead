class NewslettersController < ApplicationController
  before_action :redirect_if_logged_off

  def send_newsletter
    # Get list of apporteurs
    apporteurs = Apporteur.all
    emails = []
    @from = "MonLead@itw.be"

    # Puts all apporteurs emails into an array
    apporteurs.each do |e|
      emails.push(e.liaison_utilisateur.email)
    end

    emails_to_string1 = emails.to_s

    emails_to_string2 = emails_to_string1[1..-1]
    emails_to_string3 = emails_to_string2[0..-2]

    if ContactMailer.with(newsletter_title: @app_aff, messages: @adress, company_name: @town, categories: params[:message], from: @from, to: params[:recipient]).newsletter_to_apporteur.deliver_later
      flash[:success] = t("controller.newsletter.sent").capitalize + "."
    else
      flash[:error] = t("controller.newsletter.error").capitalize + "."
    end
    redirect_to controller: "gestionnaires", action: "index"
  end
end
