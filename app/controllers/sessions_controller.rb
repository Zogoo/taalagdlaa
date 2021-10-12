class SessionsController < Devise::SessionsController
  before_action :authenticate_user!, only: %i[destroy]

  def create
    user = User.find_by_email(sign_in_params[:email])
    if user&.valid_password?(sign_in_params[:password])
      @current_user = user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end
