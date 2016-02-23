require 'rails_helper'
require 'factories'

RSpec.feature "DeleteCustomers", type: :feature do
  context "customer can be deleted" do
    before do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      @customer = FactoryGirl.create(:customer)
    end

    scenario "#index" do
      visit "/"

      delete_customer(@customer, true)

      expect(page).to have_content("Successfully deleted customer: #{@customer.email}")
    end

    scenario "#show" do
      visit "/"

      expect(page).to have_content(@customer.email)
      find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click

      delete_customer(@customer, true)

      expect(page).to have_content("Successfully deleted customer: #{@customer.email}")
    end
  end

  context "customer cannot be deleted" do
    before do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      @customer = FactoryGirl.create(:customer)
    end

    scenario "#index" do
      visit "/"

      delete_customer(@customer, false)

      expect(page).to have_content("Cannot delete customer!")
    end

    scenario "#show" do
      visit "/"

      expect(page).to have_content(@customer.email)
      find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click

      delete_customer(@customer, false)

      expect(page).to have_content("Cannot delete customer!")
    end
  end
end

def delete_customer(customer, pass)
  expect(page).to have_content(customer.phone)

  find('button[data-title="Delete"][data-email="' + customer.email + '"]').click
  #page.driver.debug

  if(!pass)
    customer.destroy!
  end

  within('div.modal.fade.in') do
    find('a[data-method="delete"]').click
  end
end