require 'rails_helper'
require 'factories'

RSpec.feature "EditCustomers", type: :feature do
  context "customer can be edited" do
    before do
      user = FactoryGirl.create(:user)
      login_as(user)
      @customer = FactoryGirl.create(:customer)
    end

    scenario "#index" do
      visit "/"

      expect(page).to have_content(@customer.email)
      edit_customer_success(:customer => @customer)
    end

    scenario "#show" do
      visit "/"

      expect(page).to have_content(@customer.email)

      find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click
      expect(page).to have_content(@customer.phone)

      edit_customer_success(:customer => @customer)
    end
  end

  context "customer cannot be edited" do
    before do
      user = FactoryGirl.create(:user)
      login_as(user)
      @customer = FactoryGirl.create(:customer)
    end

    scenario "#index" do
      visit "/"

      expect(page).to have_content(@customer.email)
      edit_customer_fail(:customer => @customer)
    end

    scenario "#show" do
      visit "/"

      expect(page).to have_content(@customer.email)

      find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click
      expect(page).to have_content(@customer.phone)

      edit_customer_fail(:customer => @customer)
    end

  end
end

private

def edit_customer_success(args)
  find('a[href="' + edit_customer_path(args[:customer]) + '"]').click
  expect(page).to have_content(args[:customer].phone)

  fill_in "customer_organisation_name", with: "Apple Inc."
  find('span[data-title="Update"]').click
  expect(page).to have_content("Update customer")

  find('button.btn.btn-success').click
  expect(page).to have_current_path(customer_path(args[:customer]))
  expect(page).to have_content("Apple Inc.")
end

def edit_customer_fail(args)
  find('a[href="' + edit_customer_path(args[:customer]) + '"]').click
  expect(page).to have_content(args[:customer].phone)

  fill_in "customer_email", with: "wrong-mail-format"
  fill_in "customer_first_name", with: ""
  fill_in "customer_last_name", with: ""
  find('span[data-title="Update"]').click
  expect(page).to have_content("Update customer")

  find('button.btn.btn-success').click
  expect(page).to have_current_path(customer_path(args[:customer]))
  expect(page).to have_content("Email email format not valid")
  expect(page).to have_content("First name can't be blank")
  expect(page).to have_content("Last name can't be blank")
end