FactoryBot.define do
  factory :user do
    full_name { FFaker::Name.unique.name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    address { FFaker::Address.street_name }
    cpf { FFaker::IdentificationBR.cpf }
    cellphone { FFaker.numerify('###############') }
    admin { false }
  end

  trait :admin do
    admin { true }
  end
end
