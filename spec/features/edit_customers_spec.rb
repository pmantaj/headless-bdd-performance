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
      edit_customer_success
    end

    scenario "#show" do
      visit "/"

      expect(page).to have_content(@customer.email)

      find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click
      expect(page).to have_content(@customer.phone)

      edit_customer_success
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
      edit_customer_fail
    end

    scenario "#show" do
      visit "/"

      expect(page).to have_content(@customer.email)

      find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click
      expect(page).to have_content(@customer.phone)

      edit_customer_fail
    end

  end
end

def edit_customer_success
  find('a[href="' + edit_customer_path(@customer) + '"]').click
  expect(page).to have_content(@customer.phone)

  fill_in "customer_organisation_name", with: "Apple Inc."
  find('span[data-title="Update"]').click
  expect(page).to have_content("Update customer")

  find('button.btn.btn-success').click
  expect(page).to have_current_path(customer_path(@customer))
  expect(page).to have_content("Apple Inc.")
end

def edit_customer_fail
  find('a[href="' + edit_customer_path(@customer) + '"]').click
  expect(page).to have_content(@customer.phone)

  fill_in "customer_email", with: "wrong-mail-format"
  fill_in "customer_first_name", with: ""
  fill_in "customer_last_name", with: ""
  find('span[data-title="Update"]').click
  expect(page).to have_content("Update customer")

  find('button.btn.btn-success').click
  expect(page).to have_current_path(customer_path(@customer))
  expect(page).to have_content("Email email format not valid")
  expect(page).to have_content("First name can't be blank")
  expect(page).to have_content("Last name can't be blank")
end