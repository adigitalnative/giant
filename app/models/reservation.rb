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

  before_validation :set_new_record_status_to_pending

  private

  def set_new_record_status_to_pending
    if self.new_record?
      pending_status = Status.find_by_name("Pending")
      if pending_status
        self.status_id = pending_status.id
      else
        pending_status = Status.create(name: "Pending")
        self.status_id = pending_status.id
      end
    end
  end

end
