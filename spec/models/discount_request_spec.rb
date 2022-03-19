require 'rails_helper'

RSpec.describe DiscountRequest, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:company) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:received_discount) }
    it { is_expected.to validate_inclusion_of(:allowed).in_array([true, false]) }
  end
end
