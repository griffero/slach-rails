class AddFintocIdToPaymentIntents < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_intents, :fintoc_id, :string
  end
end
