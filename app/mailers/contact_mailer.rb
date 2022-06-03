class ContactMailer < ApplicationMailer
  def contact_email
    mail(to: params[:to], subject: t("mailer.new_mail_from").capitalize.to_s + " " + params[:from])
  end

  def contact_app_aff
    mail(to: params[:to], subject: t("mailer.new_mail_from").capitalize.to_s + " " + params[:from])
  end

  def contact_admin
    mail(to: params[:to], subject: t("mailer.new_mail_from").capitalize.to_s + " " + params[:from])
  end

  # Send automatic email to every users involved in a contract
  def contract_creation_summary
    mail(to: "#{params[:company_email]}, #{params[:apporteur_email]}, #{params[:lead_email]}", subject: t("mailer.new_mail_from").capitalize.to_s + " " + params[:from])
  end

  def newsletter_to_apporteur
    # Get list of apporteurs
    apporteurs = Apporteur.all
    emails = []
    @from = "MonLead@itw.be"

    # Puts all apporteurs emails into an array
    apporteurs.each do |e|
      emails.push(e.liaison_utilisateur.email)
    end

    # convert the array with emails to a string
    emails = emails.to_s
    emails = emails[1..-1]
    emails = emails[0..-2]

    mail(to: emails, subject: t("mailer.new_manager_availble").capitalize.to_s)
  end
end
