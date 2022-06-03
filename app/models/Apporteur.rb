class Apporteur
  include Dynamoid::Document

  table name: :apporteurs, key: :id, read_capacity: 5, write_capacity: 5

  field :firstname
  field :lastname
  field :town
  field :street
  field :street_nbr, :integer
  field :iban
  field :bic

  has_many :leads, :class_name => "Lead"

  belongs_to :liaison_utilisateur, class_name: "LiaisonUtilisateur"

  # belongs_to :user # Automatically links up with the user model
end
