require 'rails_helper'

RSpec.describe 'Employee Invitation', type: :request do 
  let(:manager) {create(:user)}
  let(:company) {create(:company)}
  let(:company_user) {create(:company_user, user: manager, company: company, role: :regular)}
  
  describe '#assert_listed_employee' do
    
    it "Returns true when the user is already registered on company" do
      service = EmployeeInvitationService.new(company_user.user_id, company_user.company_id)
      
      expect(service.assert_listed_employee).to eq true
    end

    it "Returns false when the user is not registered on company yet" do
      service = EmployeeInvitationService.new(company_user.id, company_user.id)

      expect(service.assert_listed_employee).to eq false
    end
    end

    describe '#create_employee!', type: :request do
      it "Creates a new company user" do
        service = EmployeeInvitationService.new(company_user.user_id, company_user.company_id)
        service.create_employee!

        expect(CompanyUser.where(user_id: company_user.user_id, company_id: company_user.company_id).any?).to eq true

        expect { service.create_employee! }.to change(CompanyUser, :count).by(1)
      end
    end
  end
