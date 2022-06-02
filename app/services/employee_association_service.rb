class EmployeeAssociationService
  def initialize(user, email, company)
    @user = user
    @email = email
    @company = company
  end

  def check_or_create_company_association
    if user.nil?  
      EmployeeInvitationMailer.invite_employee(email).deliver_now
      {
        message: 'Email sent to new user',
        status: :ok
      }
    else
      services = EmployeeInvitationService.new(user.id, company.id)
      employee_invitation(services)
    end
  end

  private 

  def employee_invitation(service)
    return  {
          message: "User is already listed as #{company.name}'s employee",
          status: :unprocessable_entity
        } if service.assert_listed_employee

    return {
      message: "User successfully listed as #{company.name}'s employee",
      status: :ok
    } if service.create_employee!
  end

  attr_reader :user, :email, :company
end 
