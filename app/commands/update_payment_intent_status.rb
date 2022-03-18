class UpdatePaymentIntentStatus < PowerTypes::Command.new(:payment_intent)
  FINTOC_URL = 'https://api.fintoc.com/v1/payment_intents'

  def perform
    status = get_payment_intent_status
    payment_intent.update(payment_intent_status: status)
  end

  private

  def get_payment_intent_status
    url = FINTOC_URL + "/#{payment_intent}"
    headers = {
      "Authorization": ENV.fetch('FINTOC_SK_LIVE'),
      "Content-Type": 'application/json'
    }
    HTTParty.get(url, headers: headers)
  end
end
