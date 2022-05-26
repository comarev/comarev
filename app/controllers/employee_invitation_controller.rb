class EmployeeInvitationController < ApplicationController
  def create
    email = JSON.parse(request.body.read)["email"]
    to_invite_user = User.find_by(email: email)

    if to_invite_user.present?
      listed_employee = EmployeeInvitationService.new.assert_listed_employee(to_invite_user.id ,params[:company_id])
      created_employee = EmployeeInvitationService.new.create_employee(to_invite_user.id, params[:company_id]) if listed_employee.blank?

      return build_response({message: "this email #{email} has already been taken"}, :unprocessable_entity) if created_employee.blank?

      return build_response(created_employee, :created)
    end

    return redirect_to signup_path(email: email)
  end

  private

  def build_response(data, status)
    render json: data, status: status
  end
end
