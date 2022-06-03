class CheckEmployeeAssociation < ApplicationService
  def initialize(user, email, company)
    @user = user
    @email = email
    @company = company
  end

  def call
    return send_invite_to_email unless user

    if listed_employee_for_company?
      build_response("User is already listed as #{company.name}'s employee", :unprocessable_entity)
    else
      CompanyUser.create!(user_id: user.id, company_id: company.id, role: 'regular')
      build_response("User successfully listed as #{company.name}'s employee", :ok)
    end
  end

  private

  attr_reader :user, :email, :company

  def send_invite_to_email
    EmployeeInvitationMailer.invite_employee(email: email).deliver_now &&
      build_response('Email sent to new user', :ok)
  end

  def listed_employee_for_company?
    CompanyUser.where(user_id: user.id, company_id: company.id).any?
  end

  def build_response(message, status)
    { message: message, status: status }
  end
end
