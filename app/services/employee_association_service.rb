class EmployeeAssociationService
  def intialize(user, email, company)
    @user = user
    @email = email
    @company = company
  end

  def check_or_create_company_association(user, email, company)
    if user.nil?
      EmployeeInvitationMailer.join_comarev_email(email).deliver_now
      {
        message: 'Email sent to new user',
        status: :ok
      }
    else
      services = EmployeeInvitationService.new(user.id, company.id)
      if services.assert_listed_employee
        {
          message: "User is already listed as #{company.name}'s employee",
          status: :unprocessable_entity
        }
      else
        services.create_employee!
        {
          message: "User successfully listed as #{company.name}'s employee",
          status: :ok
        }
      end
    end
  end

  private 
  attr_reader :user, :email, :company
end 
