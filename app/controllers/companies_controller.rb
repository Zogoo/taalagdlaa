class CompaniesController < ApplicationController
  skip_before_action :authenticate_user, only: %i[index show]

  def index
    @companies = Company.all
  end

  def show
    @company = Company.where(email: params[:email]).or(Company.where(id: params[:id]))
  end

  def create
    @company = Company.create(company_params)
  end

  def update
    res = Company.update(company_params)
    head res ? :no_content : :bad_request
  end

  def destroy
    company = Company.find(params[:id])
    res = company.destroy
    head res ? :no_content : :bad_request
  end

  private

  def company_params
    params.permit(
      :name,
      :ratings,
      :description,
      :owner_name,
      :established_at
    )
  end
end
