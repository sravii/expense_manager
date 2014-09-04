FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Eg2 #{n}" }
    sequence(:email) { |n| "eg2#{n}@example.com"}   
    password "foobar11"
    password_confirmation "foobar11"
  end

  factory :expense do
    category 1
    amount 100.00
    created_at Time.now
    user
  end

  factory :reminder do
    category 1
    frequency 1
    alert_threshold 4
    next_pay_date Date.today
    user
  end

end