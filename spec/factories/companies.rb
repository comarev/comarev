FactoryBot.define do
  factory :company do
    name { FFaker::Name.unique.name }
    cnpj { FFaker::IdentificationBR.cnpj }
    address { FFaker::Address.street_name }
    phone { FFaker::PhoneNumberBR.phone_number }
    active { true }
    code { FFaker::PhoneNumber.phone_number }
    discount { 10 }
  end
end
