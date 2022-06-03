module ApporteursHelper
  def allApporteurs
    Apporteur.all
  rescue StandardError
    []
  end

  def getAppAffName(id)
    begin
      lead = Apporteur.find(id)
      lead.firstname + " " + lead.lastname
    rescue
      []
    end
  end

  def getAppAffEmail(id)
    begin
      Apporteur.find(id).liaison_utilisateur.email
    rescue
      []
    end
  end
end
