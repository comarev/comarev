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
      case @accepted
      when true
        return render json: { message: 'invite accepted' }, status: :ok if invite.accept
      when false
        return render json: { message: 'invite refused' }, status: :ok if invite.refuse
      end
    end
    render json: { message: 'invite could not replied' }, status: :unprocessable_entity
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end
end
