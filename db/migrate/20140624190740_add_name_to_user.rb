class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
  end
end

# table name, column name, data type are the 3 parameters