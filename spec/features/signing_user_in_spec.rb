require 'rails_helper'
require 'factories'

RSpec.feature "SigningUserIn", type: :feature do
  before do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    @customer = FactoryGirl.create(:customer)
  end

  scenario "valid credential" do
    visit "/"

    expect(page).to have_content("Customer List")
    expect(page).to have_content(@customer.email)
    #expect(page).to have_selector(".glyphicon-pencil")
  end
end
