class UpdatePaymentIntentStatus < PowerTypes::Command.new(:payment_intent)
  FINTOC_URL = 'https://api.fintoc.com/v1/payment_intents'

  def perform
    payment_intent = get_payment_intent
    status = payment_intent['status']
    previous_status = @payment_intent.payment_status
    @payment_intent.update!(payment_status: status)
    if previous_status != 'succeeded' && status == 'succeeded'
      sender_rut = payment_intent['sender_account']['holder_id']
      UserMailer.payment_succeeded(@payment_intent, sender_rut).deliver
    end
  end

  private

  def get_payment_intent
    return if @payment_intent.fintoc_id.blank?

    url = FINTOC_URL + "/#{@payment_intent.fintoc_id}"
    headers = {
      "Authorization": ENV.fetch('FINTOC_SK_LIVE'),
      "Content-Type": 'application/json'
    }
    HTTParty.get(url, headers: headers)
  end
end
