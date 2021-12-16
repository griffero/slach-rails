class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def create
    user_params = {
      rut: params[:rut],
      name: GetNameFromRut.for(rut: params[:rut]),
      account_number: params[:accountNumber],
      account_type: params[:accountType],
      bank: params[:bank],
      email: params[:email],
      alias: params[:alias]
    }
    user = User.create!(user_params)
    render json: {
      data: Api::V1::UserSerializer.new(user)
    }
  rescue ActiveRecord::RecordInvalid => e
    render json: e.message, status: :bad_request
  end

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
