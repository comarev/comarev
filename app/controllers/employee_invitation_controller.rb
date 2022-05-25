class EmployeeInvitationController < ApplicationController
  def create
    email = get_email_from_body
    to_invite_user = get_invite_user_by_email(email)
    is_not_user = to_invite_user.present?

    if is_not_user
      listed_employee = CompanyUser.where(company_id: params[:company_id], user_id: to_invite_user.id)
      created_employee = CompanyUser.create!(company_id: params[:company_id], user_id: to_invite_user.id, role: "regular") if listed_employee.blank?

      return build_response({message: "this email #{email} has already been taken"}, :unprocessable_entity) if created_employee.blank?

      return build_response(created_employee, :created)
    end

    return redirect_to signup_path(email: email)
  end
  
  private

  def employee_invitation_params
    params.permit([:email, :company_id])
  end

  def build_response(data, status)
    render json: data, status: status
  end

  def get_invite_user_by_email(email)
    User.find_by(email: email)
  end
  
  def get_email_from_body
    body = JSON.parse(request.body.read)
    body["email"]
  end
end
