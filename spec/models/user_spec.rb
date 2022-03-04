require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:cellphone) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:cpf) }

    it { is_expected.to validate_length_of(:cpf).is_equal_to(11) } # 41779707866
    it { is_expected.to validate_length_of(:cellphone).is_equal_to(15) } # +55011981949538

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to have_many(:companies) }
    it { is_expected.to have_many(:company_users).dependent(:destroy) }
  end

  describe 'scopes' do
    describe '.admins' do
      subject { described_class.admins }

      let!(:admin) { create(:user, :admin) }
      let!(:user) { create(:user) }

      it { is_expected.to include(admin) }
      it { is_expected.not_to include(user) }
    end
  end
end
