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

      delete_customer(:customer => @customer, :pass => true)

      expect(page).to have_content("Successfully deleted customer: #{@customer.email}")
    end

    scenario "#show" do
      visit "/"

      expect(page).to have_content(@customer.email)
      find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click

      delete_customer(:customer => @customer, :pass => true)

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

      delete_customer(:customer => @customer, :pass => false)

      expect(page).to have_content("Cannot delete customer!")
    end

    scenario "#show" do
      visit "/"

      expect(page).to have_content(@customer.email)
      find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click

      delete_customer(:customer => @customer, :pass => false)

      expect(page).to have_content("Cannot delete customer!")
    end
  end
end

private

def delete_customer(args = {pass => false})
  expect(page).to have_content(args[:customer].phone)

  find('button[data-title="Delete"][data-email="' + args[:customer].email + '"]').click
  #page.driver.debug

  if(!args[:pass])
    args[:customer].destroy!
  end

  within('div.modal.fade.in') do
    find('a[data-method="delete"]').click
  end
end