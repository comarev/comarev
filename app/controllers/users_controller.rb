class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = authorize User.where(admin: false)
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    authorize(User)
    @user = User.create!(user_params)

    render json: @user, status: :created
  end

  def update
    @user.update!(permitted_attributes(@user))

    render json: @user, status: :ok
  end

  def destroy
    @user.destroy!

    render json: @user, status: :ok
  end

  private

  def set_user
    @user = authorize User.find(params[:id])
  end

  def user_params
    user_params = %i[full_name email password cpf address cellphone admin active avatar]
    params.require(:user).permit(user_params)
  end
end
