require 'rails_helper'
require 'factories'

RSpec.feature "DeleteCustomers", type: :feature, :js => true do
  before do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    @customer = FactoryGirl.create(:customer)
  end

  scenario "delete customer" do
    visit "/"

    expect(page).to have_content(@customer.email)

    find('button[data-title="Delete"][data-email="' + @customer.email + '"]').click

    #expect(page).to have_content("Delete Customer")
  end
end
