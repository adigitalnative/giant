class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name, :item_type_ids, :archived

  has_many :item_type_assignments
  has_many :item_types, through: :item_type_assignments
  has_many :reservations

  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true }

  def belongs_to?(possible_owner)
    if possible_owner.id == user.id
      true
    else
      false
    end
  end
end
