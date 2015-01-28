class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :phone, :account_type_ids
  # attr_accessible :title, :body

  has_many :user_account_types
  has_many :account_types, through: :user_account_types

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    [first_name, last_name].join(" ")
  end

  def account_types_list
    roles.join(", ")
  end

  def roles
    account_types.map {|at| at.name }
  end

end
