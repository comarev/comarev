class InviteEmployeeService < ApplicationService
  def initialize(inviter, email, company)
    @inviter = inviter
    @email = email
    @company = company
  end

  def call
    if listed_employee_for_company?
      build_response("User is already listed as #{company.name}'s employee", :unprocessable_entity)
    elsif invite_already_sent?
      build_response("User was already invited to #{company.name}", :unprocessable_entity)
    else
      send_invitation_email
    end
  end

  private

  attr_reader :inviter, :email, :company

  def send_invitation_email
    invitation = Invite.create!(inviter_id: inviter.id, invited_email: email)
    if invitation
      EmployeeInvitationMailer.with(token: invitation.invitation_token, 
                                    email: email, 
                                    company: company)
                              .invite_employee.deliver_now &&
      build_response('Invitation sent', :ok)
    else
      build_response('Invitation could not be sent', :unprocessable_entity)
    end
  end

  def listed_employee_for_company?
    user = User.find_by(email: email)
    if user
      CompanyUser.where(user_id: user.id, company_id: company.id).any?
    else
      return false
    end
  end

  def invite_already_sent?
    Invite.available.where(invited_email: email, inviter: inviter.id).any?
  end

  def build_response(message, status)
    { message: message, status: status }
  end

  def build_response(message, status)
    { message: message, status: status }
  end
end
