class Api::V1::FintocController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  # FINTOC_API_KEY = ENV.fetch('FINTOC_API_KEY')

  def webhook
    username = params[:data][:username]
    institution = params[:data][:institution][:id]
    accounts = []
    params[:data][:accounts].each do |account|
      next if account[:currency] != 'CLP'

      account_information = {
        balance: { available: account[:balance][:available] },
        account_number: account[:number],
        account_type: account[:type],
        currency: account[:currency]
      }
      accounts << account_information
    end
    response = {
      full_name: params[:data][:accounts][0][:holder_name],
      rut: username,
      bank: institution,
      accounts: accounts
    }
    key = "slach:#{params[:id]}"
    if REDIS_CONNECTION.exists?(key)
      REDIS_CONNECTION.set(key, response.to_json)
      REDIS_CONNECTION.expire(key, 1800) # Expire data in 30 minutes.
    end
  end
end
