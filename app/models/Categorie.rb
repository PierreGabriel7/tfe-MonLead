class Categorie
  include Dynamoid::Document

  table name: :categories, key: :id, read_capacity: 5, write_capacity: 5

  field :name


  has_many :leads, :class_name => 'Lead'


end
