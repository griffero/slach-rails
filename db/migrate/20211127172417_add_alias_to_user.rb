class AddAliasToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :alias, :string, null: false
  end
end
