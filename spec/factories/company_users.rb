FactoryBot.define do
  factory :company_user do
    company
    user
    role { CompanyUser.roles.values.sample }

    trait :regular do
      role { :regular }
    end

    trait :manager do
      role { :manager }
    end
  end
end
