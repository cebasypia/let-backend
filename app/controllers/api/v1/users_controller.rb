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
    if params[:user][:file].match(/https?:\/\/[\S]+/)
      @current_user.update(profileImageUrl: params[:user][:file])
    elsif params[:user][:file].match(/data:image\/jpeg;base64/)
      @current_user.update(profileImageUrl: attach_avatar(params[:user][:file]))
    end
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

  def attach_avatar(file)
    blob = ActiveStorage::Blob.create_after_upload!(
      io: StringIO.new(Base64.decode64(file.split(",")[1])),
      filename: "#{@current_user.name}.png",
      content_type: "image/png",
    )
    @current_user.avatar.attach(blob)
    url_for(@current_user.avatar)
  end
end
