class Api::V1::UsersController < ActionController::API
  include Secured

  before_action :set_user, only: [:show]
  before_action :authenticate_request!, only: [:update]

  def show
    render json: @user
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user, status: :ok
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(sub: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
