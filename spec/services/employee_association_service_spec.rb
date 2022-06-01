require 'rails_helper'

RSpec.describe EmployeeAssociationService, type: :service do
  let(:user) { create(:user) }
  let(:already_registered_user) {create(:user) }
  let(:company) { create(:company) }
  let!(:company_user) { create(:company_user, user: already_registered_user, company: company, role: :regular) }

  describe '#check_or_create_company_association' do
    subject(:check_association) do
      described_class.new.check_or_create_company_association(*args)
    end

    context 'when the user not registered on Comarev yet' do
      let(:args) { [ nil, "not_registered_email", company ] }
      it {is_expected.to eq({message: 'Email sent to new user', status: :ok})}
    end
  end

  describe 'when the user is registered on Comarev' do
    subject(:check_association) do
      described_class.new.check_or_create_company_association(*args)
    end

    context 'and is a company employee' do
      let(:args) { [ already_registered_user, already_registered_user.email, company ] }
        it {is_expected.to eq({message: "User is already listed as #{company.name}'s employee", status: :unprocessable_entity})}
    end

    context 'but not as a company employee' do
      let(:args) { [ user, user.email, company ] }
        it {is_expected.to eq({message: "User successfully listed as #{company.name}'s employee", status: :ok})}
    end
  end
end

