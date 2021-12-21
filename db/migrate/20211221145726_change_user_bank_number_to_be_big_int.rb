class ChangeUserBankNumberToBeBigInt < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :account_number, :bigint
  end
end
