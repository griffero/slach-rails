class ChangePaymentIntentAccountNumberToBeBigInt < ActiveRecord::Migration[6.0]
  def change
    change_column :payment_intents, :recipient_account_number, :bigint
  end
end
