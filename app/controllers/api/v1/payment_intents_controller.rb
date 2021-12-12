class Api::V1::PaymentIntentsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(alias: params[:data][:userAlias])
    amount = params[:data][:amount]
    widget_token = CreatePaymentIntent.for(user: user, amount: amount)
    render json: {
      widget_token: widget_token
    }
  end
end
