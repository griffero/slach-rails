class CreatePaymentIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_intents do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount, null: false
      t.string :recipient_account_holder_id, null: false
      t.integer :recipient_account_number, null: false
      t.string :recipient_account_type, null: false
      t.string :recipient_account_institution_id, null: false

      t.timestamps
    end
  end
end
