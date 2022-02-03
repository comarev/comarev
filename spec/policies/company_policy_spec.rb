require 'rails_helper'

describe CompanyPolicy, type: :policy do
  subject { described_class.new(user, new_company) }

  let(:new_company) { build_stubbed(:company) }

  context 'when a regular user' do
    let(:user) { build_stubbed(:user) }

    it { is_expected.to authorize(:index) }
    it { is_expected.not_to authorize(:create) }
    it { is_expected.not_to authorize(:show) }
    it { is_expected.not_to authorize(:destroy) }
    it { is_expected.not_to authorize(:update) }
  end

  context 'when an admin user' do
    let(:user) { build_stubbed(:user, :admin) }

    it { is_expected.to authorize(:create) }
    it { is_expected.to authorize(:index) }
    it { is_expected.to authorize(:show) }
    it { is_expected.to authorize(:destroy) }
    it { is_expected.to authorize(:update) }
  end

  context 'when manager user' do
    let(:user) { create(:user) }
    let(:new_company) { create(:company) }

    before do
      create(:company_user, :manager, company: new_company, user: user)
    end

    it { is_expected.to authorize(:index) }
    it { is_expected.to authorize(:show) }
    it { is_expected.to authorize(:update) }
    it { is_expected.not_to authorize(:create) }
    it { is_expected.not_to authorize(:destroy) }
  end

  context 'when regular user from the company' do
    let(:user) { create(:user) }
    let(:new_company) { create(:company) }

    before do
      create(:company_user, :regular, company: new_company, user: user)
    end

    it { is_expected.to authorize(:index) }
    it { is_expected.to authorize(:show) }
    it { is_expected.not_to authorize(:create) }
    it { is_expected.not_to authorize(:destroy) }
    it { is_expected.not_to authorize(:update) }
  end

  describe '#permitted_attributes' do
    subject { described_class.new(user, company).permitted_attributes }

    context 'when admin user' do
      let(:company) { build_stubbed(:company) }
      let(:user) { create(:user, :admin) }

      it do
        is_expected.to match_array [
          :name, :cnpj, :address, :phone, :active, :discount,
          { manager_ids: [], regular_ids: [] }
        ]
      end
    end

    context 'when manager user' do
      let(:company) { build_stubbed(:company) }
      let(:user) { create(:user) }

      before do
        build_stubbed(:company_user, :manager, company: company, user: user)
      end

      it do
        is_expected.to match_array [
          :name, :cnpj, :address, :phone, :active,
          { manager_ids: [], regular_ids: [] }
        ]
      end
    end

    context 'when regular user' do
      let(:company) { build_stubbed(:company) }
      let(:user) { create(:user) }

      before do
        build_stubbed(:company_user, :regular, company: company, user: user)
      end

      it do
        is_expected.to match_array [
          :name, :cnpj, :address, :phone, :active,
          { manager_ids: [], regular_ids: [] }
        ]
      end
    end
  end

  describe 'policy_scope' do
    subject { described_class::Scope.new(user, Company.all).resolve }

    let!(:company1) { create(:company) }
    let!(:company2) { create(:company) }

    context 'when admin user' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to include(company1) }
      it { is_expected.to include(company2) }
    end

    context 'when other user' do
      let(:user) { create(:user) }

      before { create(:company_user, :regular, company: company1, user: user) }

      it { is_expected.to include(company1) }
      it { is_expected.not_to include(company2) }
    end
  end
end
