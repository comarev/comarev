FactoryBot.define do
  factory :company_user do
    company { nil }
    user { nil }
    role { 1 }
  end
end
