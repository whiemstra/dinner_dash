require 'rails_helper'

describe 'User Logout', type: :feature do

  before(:each) do
    @user = User.create(full_name: "Tom Petty",
                        display_name: 'Tom',
                        email: "petty@gmail.com",
                        password: "freefallin")
  end

  it 'only shows a link if logged in and logs user out when clicked' do
    visit root_path
    click_on("Toggle navigation")

    expect(page).to have_content("Sign Up/Login")

    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    expect(page).to have_content("All Items")
    click_on("Toggle navigation")
    expect(page).to have_content("Log out")

    click_on("Toggle navigation")
    click_on 'Log out'

    expect(page).to have_content("You've successfully logged out.")
    click_on("Toggle navigation")
    expect(page).to have_content("Sign Up/Login")
  end

  xit 'does not allow people to access pages when logged out' do
    visit root_path
    click_on("Toggle navigation")

    expect(page).to have_content("Sign Up/Login")

    #past orders page....
  end

end

