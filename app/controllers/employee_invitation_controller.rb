class EmployeeInvitationController < ApplicationController
  before_action :set_company

  def create
    @email = params[:email]
    @user = User.find_by(email: @email)

    check_association = EmployeeAssociationService.new(@user,
      @email, @company).check_or_create_company_association

    message, status = check_association.slice(:message, :status).values

    render json: { message: message }, status: status
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end
end
