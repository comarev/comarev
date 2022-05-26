class EmployeeInvitationService 
  def initialize(user_id, company_id)
    @user_id = user_id
    @company_id = company_id
  end

  def assert_listed_employee
    CompanyUser.where(company_id: company_id, user_id: user_id).any?
  end

  def create_employee!
    CompanyUser.create!(company_id: company_id, user_id: user_id, role: 'regular')
  end

  private 

  attr_reader :user_id, :company_id
end
