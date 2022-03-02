FactoryBot.define do
  factory :company do
    name { FFaker::Name.unique.name }
    cnpj { FFaker::IdentificationBR.cnpj }
    address { FFaker::Address.street_name }
    phone { 11111111111111 }
    active { true }
    discount { 10 }
  end
end
