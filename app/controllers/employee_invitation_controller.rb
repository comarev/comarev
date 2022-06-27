class EmployeeInvitationController < ApplicationController
  before_action :set_company

  def create
    @email = params[:email]
    @user = current_user

    message, status = InviteEmployeeService.call(@user, @email, @company)
      .slice(:message, :status).values

    render json: { message: message }, status: status
  end

  def update
    @token = params[:token]
    @accepted = params[:accepted]

    if (invite = Invite.available.find_by(invitation_token: @token))
      if @accepted
        invite.accept
        render json: { message: 'Invite accepted' }, status: :ok
      else
        invite.refuse
        render json: { message: 'Invite refused' }, status: :ok
      end
    else
      render json: { message: 'Invite could not be found' }, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end
end
