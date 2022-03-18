class UpdatePaymentIntentsJob < ApplicationJob
  queue_as :default

  def perform
    PaymentIntent.pending.where.not(fintoc_id: nil).each do |payment_intent|
      UpdatePaymentIntent.for(payment_intent: payment_intent)
    end
  end
end
