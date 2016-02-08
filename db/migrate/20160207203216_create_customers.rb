class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :organisation_name
      t.string :region
      t.string :city
      t.string :postal_code
      t.string :address_code

      t.timestamps null: false
    end
  end
end
