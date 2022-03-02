require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { create(:company) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cnpj) }

    it { is_expected.to validate_length_of(:cnpj).is_equal_to(14) }
    it { is_expected.to validate_length_of(:phone).is_equal_to(14) }

    it { is_expected.to validate_uniqueness_of(:cnpj).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to have_many(:users) }

    it {
      is_expected.to have_many(:managers)
        .conditions(company_users: { role: :manager })
        .through(:company_users)
        .source(:user)
    }

    it {
      is_expected.to have_many(:regulars)
        .conditions(company_users: { role: :regular })
        .through(:company_users)
        .source(:user)
    }
  end

  describe 'callbacks' do
    describe 'assign_code' do
      subject { company.code }

      let(:company) { build(:company, code: nil) }

      before { company.save }

      it { is_expected.to be_present }
    end
  end
end
