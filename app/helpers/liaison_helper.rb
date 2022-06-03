module LiaisonHelper
    def allLiaisons
        LiaisonUtilisateur.all
      rescue StandardError
        []
      end
end
