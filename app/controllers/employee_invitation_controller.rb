class EmployeeInvitationController < ApplicationController
  before_action :set_company

  def create
    @email = params[:email]
    @user = User.find_by(email: @email)

    check_association = EmployeeAssociationService.new.check_or_create_company_association(@user, @email, @company)

    render json: { message: check_association[:message] }, status: check_association[:status]
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
