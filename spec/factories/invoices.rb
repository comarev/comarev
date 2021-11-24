FactoryBot.define do
  factory :invoice do
    user
    amount { 10.0 }
    paid { false }
    status { Invoice.statuses.keys.sample }
  end
end
