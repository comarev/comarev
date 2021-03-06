FactoryBot.define do
  factory :invoice do
    user
    amount_cents { 10_00 }
    paid { false }
    due_date { 3.days.from_now }
    status { Invoice.statuses.keys.sample }
  end
end
