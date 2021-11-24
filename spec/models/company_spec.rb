require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { create(:company) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cnpj) }
    it { is_expected.to validate_presence_of(:code) }

    it { is_expected.to validate_inclusion_of(:active).in_array([true, false]) }

    it { is_expected.to validate_uniqueness_of(:cnpj).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to have_many(:users) }
  end
end
