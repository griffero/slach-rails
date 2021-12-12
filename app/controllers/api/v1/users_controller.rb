class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find_by(alias: params[:id])

    if user.present?
      render json: {
        data: Api::V1::UserSerializer.new(user)
      }
    else
      render json: 'Record not found', status: :not_found
    end
  end
end
