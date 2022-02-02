require 'rails_helper'

RSpec.describe InvoicePolicy, type: :policy do
  subject { described_class.new(user, invoice) }

  let(:invoice) { build_stubbed(:invoice) }

  context 'for a regular user' do
    let(:user) { build_stubbed(:user) }

    it { is_expected.to authorize(:index) }
    it { is_expected.not_to authorize(:create) }
    it { is_expected.not_to authorize(:update) }
  end

  context 'for an admin user' do
    let(:user) { build_stubbed(:user, :admin) }

    it { is_expected.to authorize(:index) }
    it { is_expected.to authorize(:create) }
    it { is_expected.to authorize(:update) }
  end

  describe 'policy_scope' do
    subject { described_class::Scope.new(user, Invoice.all).resolve }

    let!(:invoice1) { create(:invoice) }
    let!(:invoice2) { create(:invoice) }

    context 'when admin user' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to include(invoice1) }
      it { is_expected.to include(invoice2) }
    end

    context 'when other user' do
      let(:user) { create(:user) }

      let!(:invoice3) { create(:invoice, user: user) }

      it { is_expected.to include(invoice3) }
      it { is_expected.not_to include(invoice1) }
      it { is_expected.not_to include(invoice2) }
    end
  end
end
