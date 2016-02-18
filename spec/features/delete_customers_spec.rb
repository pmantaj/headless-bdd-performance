require 'rails_helper'
require 'factories'

RSpec.feature "DeleteCustomers", type: :feature do
  before do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    @customer = FactoryGirl.create(:customer)
  end

  scenario "#index" do
    visit "/"

    expect(page).to have_content(@customer.email)

    find('button[data-title="Delete"][data-email="' + @customer.email + '"]').click
    #page.driver.debug
    #puts page.driver.network_traffic.inspect;page.driver.reset
    sleep 5
    within('div.modal.fade.in') do
      find('a[data-method="delete"]').click
    end

    expect(page).to have_content("Successfully deleted customer: #{@customer.email}")
  end

  scenario "#show" do
    visit "/"

    expect(page).to have_content(@customer.email)
    find('a[href="'+ customer_path(@customer) + '"][data-method="get"]').click
    expect(page).to have_content(@customer.phone)
  end
end
