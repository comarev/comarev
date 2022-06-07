require 'rails_helper'

RSpec.describe CheckEmployeeAssociation, type: :service do
  let(:user) { create(:user) }
  let(:company) { create(:company) }

  describe '.call' do
    subject(:check_association) { described_class.call(*args) }

    context 'when the user not registered on comarev yet' do
      let(:args) { [nil, 'not_registered_email', company] }

      it { is_expected.to eq({ message: 'Email sent to new user', status: :ok }) }
    end

    context 'when the user already exists on comarev' do
      context 'and is not listed as a company employee' do
        let(:args) { [user, user.email, company] }

        it {
          is_expected.to eq({ message: "User successfully listed as #{company.name}'s employee",
          status: :ok })
        }
      end

      context 'and is already listed as a company employee' do
        let(:args) { [user, user.email, company] }

        before { create(:company_user, user: user, company: company) }

        it {
          is_expected.to eq({ message: "User is already listed as #{company.name}'s employee",
          status: :unprocessable_entity })
        }
      end
    end
  end
end
