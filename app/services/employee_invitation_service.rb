class EmployeeInvitationService 
  def initialize(user_id, company_id)
    @user_id = user_id
    @company_id = company_id
  end

  def assert_listed_employee
    CompanyUser.where(user_id: @user_id, company_id: @company_id).any?
  end

  def create_employee!
    CompanyUser.create!(user_id: @user_id, company_id: @company_id , role: 'regular')
  end

  private

  attr_reader :user_id, :company_id
end
