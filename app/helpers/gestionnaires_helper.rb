module GestionnairesHelper
  def getGestionnaireName(id)
    begin
      Gestionnaire.find(id).company_name
    rescue
      []
    end
  end

  def getGestionnaireEmail(id)
    begin
      Gestionnaire.find(id).liaison_utilisateur.email
    rescue
      []
    end
  end
end
