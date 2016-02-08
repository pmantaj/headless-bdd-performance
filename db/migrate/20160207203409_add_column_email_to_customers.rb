class AddColumnEmailToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :email, :string
    add_index :customers, :email, unique: true
  end
end
