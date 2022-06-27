FactoryBot.define do
  factory :invite do
    inviter { create :user }
    company { create :company }
    invited_email { FFaker::Internet.email }
  end
end
