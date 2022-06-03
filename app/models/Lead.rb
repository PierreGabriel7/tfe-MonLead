class Lead
  include Dynamoid::Document

  table name: :leads, key: :id, read_capacity: 5, write_capacity: 5

  field :firstname
  field :lastname
  field :email
  field :town
  field :street
  field :street_nbr, :integer
  field :iban
  field :bic
  # field :intrested_by

  belongs_to :apporteur, :class_name => "Apporteur"
  belongs_to :categorie, :class_name => "Categorie"

  # belongs_to :user # Automatically links up with the user model
end
