class AccountType < ActiveRecord::Base
  attr_accessible :name

  has_many :user_account_types
  has_many :users, through: :user_account_types

  validates :name, presence: true
end
