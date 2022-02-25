FactoryBot.define do
  factory :discount_request do
    user
    company
    received_discount { 1 }
  end
end
