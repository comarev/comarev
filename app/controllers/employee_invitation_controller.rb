class EmployeeInvitationController < ApplicationController
  before_action :set_company
  
  def create
    @email = params[:email]
    @user = User.find_by(email: @email)
    message, status = check_or_create_company_association.slice(:message, :status).values

    render json: {message: message}, status: status
  end

  private

  def check_or_create_company_association
    if @user.nil? 
      EmployeeInvitationMailer.join_comarev_email(@email).deliver_now
      {
        message: "Email sent to new user", status: :ok
      }
      else
        services = EmployeeInvitationService.new(@user.id, @company.id)
        if services.assert_listed_employee
          { 
            message: "User is already listed as #{@company.name}'s employee", 
            status: :unprocessable_entity
          }
          else 
            services.create_employee!
            {
              message: "User is now listed as #{@company.name}'s employee", 
              status: :ok
            }
        end
    end
end

  def set_company
    @company = Company.find(params[:company_id]) 
  end
end
