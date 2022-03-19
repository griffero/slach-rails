class CreatePaymentIntent < PowerTypes::Command.new(:user, :amount)
  FINTOC_URL = 'https://api.fintoc.com/v1/payment_intents'

  def perform
    response = post_payment_intent
    payment_intent.update(fintoc_id: response['id'])
    response['widget_token']
  end

  private

  def payment_intent
    @payment_intent ||= PaymentIntent.create!(
      user_id: @user.id,
      amount: @amount,
      payment_status: 'created',
      recipient_account_holder_id: @user.rut,
      recipient_account_number: @user.account_number,
      recipient_account_type: @user.account_type,
      recipient_account_institution_id: @user.bank
    )
  end

  def post_payment_intent
    data = {
      "amount": payment_intent.amount,
      "currency": 'CLP',
      "recipient_account": {
        "holder_id": payment_intent.recipient_account_holder_id,
        "number": payment_intent.recipient_account_number,
        "type": payment_intent.recipient_account_type,
        "institution_id": payment_intent.recipient_account_institution_id
      }
    }
    headers = {
      "Authorization": ENV.fetch('FINTOC_SK_LIVE'),
      "Content-Type": 'application/json'
    }
    HTTParty.post(FINTOC_URL, query: data, headers: headers)
  end
end
