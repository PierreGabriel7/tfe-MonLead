

class Gestionnaire
    include Dynamoid::Document

    table name: :gestionnaires, key: :id, read_capacity: 5, write_capacity: 5

    field :company_name
    field :town
    field :street
    field :street_nbr, :integer
    field :iban
    field :bic



    belongs_to :liaison_utilisateur, :class_name => 'LiaisonUtilisateur'


  
    # belongs_to :user # Automatically links up with the user model
  end



