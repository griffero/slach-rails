class AddPaymentStatusToPaymentIntents < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_intents, :payment_status, :string
  end
end
