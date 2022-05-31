require 'rails_helper'

RSpec.describe EmployeeInvitationService, type: :service do
  let(:user) { create(:user) }
  let(:company) { create(:company) }
  let(:company_user) { create(:company_user, user: user, company: company, role: :regular) }

  describe '#assert_listed_employee' do
    subject(:assert_listed_employee) do
      described_class.new(*args).assert_listed_employee
    end

    context 'when the user is already registered on company' do
      let(:args) { [company_user.user_id, company_user.company_id] }

      it { is_expected.to eq true }
    end

    context 'when the user is not registered on company yet' do
      let(:args) { [100, 100] }

      it { is_expected.to eq false }
    end
  end

  describe '#create_employee!' do
    subject(:create_employee) { described_class.new(user.id, company.id).create_employee! }

    it 'Creates a new company user' do
      expect { create_employee }.to change(CompanyUser, :count).by(1)
    end
  end
end
