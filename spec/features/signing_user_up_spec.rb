require 'rails_helper'

RSpec.feature "SigningUserUp", type: :feature do
  before do
    @email = Faker::Internet.email
    @password = Faker::Internet.password(min_length=10, max_length=18)
  end

  scenario "valid credential" do
    visit "/"

    expect(page).to have_content "Sign up"

    click_link "Sign up"

    expect(page).to have_content "Password confirmation"

    fill_in "Email", with: @email
    fill_in "Password", with: @password
    fill_in "Password confirmation", with: @password
    find('input[name="commit"]').click

    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end
