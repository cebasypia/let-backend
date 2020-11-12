class Api::V1::UsersController < ActionController::API
  include Secured

  before_action :authenticate_request!, only: [:create, :update]
  before_action :set_user, only: [:show]

  def show
    render json: @user
  end

  def create
    @user = register_authenticated_user
    if @user
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
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
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :description)
  end
end
