class AddBankToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bank, :string, null: false
  end
end
