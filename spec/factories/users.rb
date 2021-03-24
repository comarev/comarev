# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    address { Faker::Address.street_name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    cellphone { Faker::PhoneNumber.cell_phone_in_e164 }
  end

  trait :admin do
    admin { true }
  end
end
