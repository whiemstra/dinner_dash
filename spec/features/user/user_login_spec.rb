require 'rails_helper'

describe 'user log in', type: :feature do

  before(:each) do
    @user = User.create(full_name: "Tom Petty",
                        display_name: 'Tom',
                        email: "petty@gmail.com",
                        password: "freefallin")
    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click
  end

  it 'has a link on the home page that links to a sign up form' do
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
    expect(page).to have_button('Login')
  end

  it "can log in an existing user and redirects to items page" do
    fill_in "Email", with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    expect(page).to have_content("Hello, Tom")
    expect(current_path).to have_content(items_path)
  end

  it 'sends people to the login page if not logged in' do
    fill_in "Email", with: "abc@email.com"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_content("Invalid email/password combination")
    expect(page).to have_content("Sign up now!")
  end

  it 'errors if email does not exist' do
    fill_in "Email", with: "abc@email.com"
    fill_in "Password", with: "freefallin"
    click_button "Login"

    expect(page).to have_content("Invalid email/password combination")

  end

  it 'errors if email exists but password is wrong' do
    fill_in "Email", with: "petty@gmail.com"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_content("Invalid email/password combination")

  end

  it 'errors if email and password are blank' do
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Login"

    expect(page).to have_content("Invalid email/password combination")
  end
end
