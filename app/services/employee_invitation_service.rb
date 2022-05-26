class EmployeeInvitationService 
  
  def assert_listed_employee(user, company)
    CompanyUser.where(company_id: company, user_id: user)
  end

  def create_employee(user, company)
    CompanyUser.create!(company_id: company, user_id: user, role: "regular")
  end
end
