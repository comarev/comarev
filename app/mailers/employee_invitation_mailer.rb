class EmployeeInvitationMailer < ApplicationMailer

  default from: "test@test.com"

  def join_comarev_email(email)
    # @url = url to login + token
    mail(to: email, 
      subject: 'Invitation to join Comarev',
      template_path: 'employee_invitation',
      template_name: 'join_comarev_email') 
    
  end

end
