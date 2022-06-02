class EmployeeInvitationMailer < ApplicationMailer
  default from: 'test@test.com'

  def invite_employee(email)
    mail(to: email,
      subject: 'Comarev - Invitation to join in',
      template_path: 'employee_invitation',
      template_name: 'invite_employee')
  end
end
