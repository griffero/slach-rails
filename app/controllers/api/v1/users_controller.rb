class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find_by(alias: params[:id])

    render json: {
      data: Api::V1::UserSerializer.new(user)
    }
  end
end
