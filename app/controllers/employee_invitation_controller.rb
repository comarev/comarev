class EmployeeInvitationController < ApplicationController
  before_action :set_company

  def create
    @email = params[:email]
    @user = current_user

    message, status = InviteEmployeeService.call(@user, @email, @company)
      .slice(:message, :status).values

    render json: { message: message }, status: status
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end
end
