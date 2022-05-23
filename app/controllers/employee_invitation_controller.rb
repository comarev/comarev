class EmployeeInvitationController < ApplicationController
  def create
    @company = Company.find(params[:id])
    json_params = JSON.parse(request.body.read)
    @email = json_params["email"]
    employee = @company.users.where(email: @email).blank?

    return render json: { message: "this email: #{@email} has already been taken" }, status: :unprocessable_entity unless employee

    render json: { status: 200 }

  end

end
