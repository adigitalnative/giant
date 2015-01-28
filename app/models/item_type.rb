class ItemType < ActiveRecord::Base
  attr_accessible :name

  has_many :item_type_assignments
  has_many :items, through: :item_type_assignments

  validates :name, presence: true
end
