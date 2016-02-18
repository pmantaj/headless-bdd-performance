class AddColumnPhoneToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :phone, :string
    Customer.all.each do |customer|
      customer.update(phone: Faker::PhoneNumber.cell_phone)
    end
  end
end
