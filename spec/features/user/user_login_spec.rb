require 'rails_helper'

describe 'user log in', type: :feature do

  before(:each) do
    @user = User.create(full_name: "Tom Petty",
                        display_name: 'Tom',
                        email: "petty@gmail.com",
                        password: "freefallin")
  end

  xit 'has a link on the home page that links to a sign up form' do
    visit items_path
    expect(page).to have_link('Sign In', login_path)

    click_link "Sign In"
    expect(page).to have_text('Login')
  end

  it "can log in an existing user" do
    visit root_path

    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    expect(page).to have_content("Hello, Tom")
  end


  xit 'sends people to the login page if not logged in'
  xit 'redirects to the items page after logging in'
  xit 'errors if fullname does not exist'
  xit 'errors if fullname exists but password is wrong'
  xit 'errors if fullname and password are blank'
end
