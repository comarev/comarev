require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    before { create(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:cellphone) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:cpf) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
  end
end
