class UpdatePaymentIntentStatus < PowerTypes::Command.new(:payment_intent)
  FINTOC_URL = 'https://api.fintoc.com/v1/payment_intents'

  def perform
    status = get_payment_intent_status
    @payment_intent.update!(payment_status: status)
  end

  private

  def get_payment_intent_status
    return if @payment_intent.fintoc_id.blank?

    url = FINTOC_URL + "/#{@payment_intent.fintoc_id}"
    headers = {
      "Authorization": ENV.fetch('FINTOC_SK_LIVE'),
      "Content-Type": 'application/json'
    }
    HTTParty.get(url, headers: headers)['status']
  end
end
