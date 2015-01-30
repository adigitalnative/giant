FactoryGirl.define do
  factory :reservation do
    user_id 0
    item_id 0
    status_id 0
    start_date Date.today
    end_date Date.today + 10
  end
end