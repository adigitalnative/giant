class ItemTypeAssignment < ActiveRecord::Base
  belongs_to :item_type
  belongs_to :item


  validates :item_type_id, presence: true, numericality: { only_integer: true }  
  validates :item_id, presence: true, numericality: { only_integer: true }  
end
