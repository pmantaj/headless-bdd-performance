require 'rails_helper'
require 'factories'

RSpec.feature "SigningUserIn", type: :feature do
  before do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  scenario "valid credential" do
    visit "/"

    expect(page).to have_content("BDD View")
  end
end
