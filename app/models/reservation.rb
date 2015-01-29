class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :status
  attr_accessible :end_date, :start_date

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :status_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  # before_create :set_status_to_pending

  # def set_status_to_pending
  #   pending_status = Status.find_by_name("Pending")
  #   status_id = pending_status.id
  # end

  # def initialize(attributes = {})
  #   pending_status = Status.find_by_name("Pending")
  #   if pending_status
  #     # status_id = pending_status.id
  #     super
  #   else
  #     pending_status = Status.create(name: "Pending")
  #     status_id = pending_status.id
  #     super
  #   end
  # end
end
