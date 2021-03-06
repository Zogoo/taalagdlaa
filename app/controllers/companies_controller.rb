class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @companies = Company.active
  end

  def show
    @company = Company.where(
      name: params[:name],
      status: :active
    ).or(
      Company.where(
        id: params[:id],
        status: :active
      )
    ).first
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
