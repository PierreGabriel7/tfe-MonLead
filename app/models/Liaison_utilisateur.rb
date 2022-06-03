class LiaisonUtilisateur
  include Dynamoid::Document

  table name: :liaison_utilisateurs, key: :id, read_capacity: 5, write_capacity: 5

  field :email

  has_one :apporteur, class_name: "Apporteur"
  has_one :administrateur, class_name: "Administrateur"
  has_one :gestionnaire, class_name: "Gestionnaire"

  # belongs_to :user # Automatically links up with the user model

end
