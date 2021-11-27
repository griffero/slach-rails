class AddAccountTypeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :account_type, :string, null: false
  end
end
