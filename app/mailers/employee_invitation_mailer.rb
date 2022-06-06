class EmployeeInvitationMailer < ApplicationMailer
  default from: 'test@test.com'

  def invite_employee
    @email = params[:email]

    mail(to: @email,
      subject: 'Comarev - Invitation to join in')
  end
end
