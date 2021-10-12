class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]

  def index
    authorize(Company)

    @companies = policy_scope(Company).order(:name)

    render json: @companies, status: :ok
  end

  def show
    render json: @company, status: :ok
  end

  def create
    authorize(Company)
    @company = Company.create!(company_params)

    render json: @company, status: :created
  end

  def update
    @company.update_attributes!(permitted_attributes(@company))

    render json: @company, status: :ok
  end

  def destroy
    @company.destroy!

    render json: @company, status: :ok
  end

  private

  def set_company
    @company = authorize Company.find(params[:id])
  end

  def company_params
    company_params = %i[name cnpj address phone active code discount].push(user_ids: [])
    params.require(:company).permit(company_params)
  end
end
