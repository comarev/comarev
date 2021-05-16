require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { create(:company) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cnpj) }
    it { is_expected.to validate_presence_of(:active) }

    it { is_expected.to validate_uniqueness_of(:cnpj).case_insensitive }
  end
end
