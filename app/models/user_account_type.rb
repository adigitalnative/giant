class UserAccountType < ActiveRecord::Base
  belongs_to :user
  belongs_to :account_type
  # attr_accessible :title, :body

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :account_type_id, presence: true, numericality: { only_integer: true }
end
