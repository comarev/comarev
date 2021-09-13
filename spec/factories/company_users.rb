FactoryBot.define do
  factory :company_user do
    company
    user
    role { 1 }
  end
end
