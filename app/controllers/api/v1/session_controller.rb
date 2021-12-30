class Api::V1::SessionController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def create
    session = SecureRandom.base58(24)
    REDIS_CONNECTION.set("slach:#{session}", '')
    render json: { session: session }, status: :ok
  end

  def show
    data = { status: 'syncing' }
    key = "slach:#{params[:id]}"
    if REDIS_CONNECTION.exists?(key) && REDIS_CONNECTION.get(key) != ''
      data = JSON.parse(REDIS_CONNECTION.get(key))
    end
    render json: data, status: :ok
  end
end
