require 'rails_helper'


describe 'user signup', type: :feature do

  xit 'has a link on the home page that links to a sign up form' do
    visit items_path
    expect(page).to have_link('Signup', new_user_path)

    click_link "Signup"
    expect(page).to have_text('Create Your Account')

  end

  it 'can create an account' do
    visit new_user_path
    expect(page).to have_text('Create Your Account')

    within('#new_user') do
      fill_in "Full Name",    with: "Whitney"
      fill_in "Display Name", with: "whithub"
      fill_in "Email",        with: "WhitTheShit@gmail.com"
      fill_in "Password",     with: "dinnerdash"
      click_button "Create Account"
    end

    expect(page).to have_content("All Items")
    expect(current_path).to eql(items_path)
  end

  it 'can sign up without a display name' do
    visit new_user_path
    expect(page).to have_text('Create Your Account')

    within('#new_user') do
      fill_in "Full Name", with: "Drewby Mine"
      fill_in "Email",     with: "drewbyonrails@gmail.com"
      fill_in "Password",  with: "pa$$word"
      click_button "Create Account"
    end

    expect(page).to have_content("All Items")
    expect(current_path).to eql(items_path)
  end


  it 'errors if full_name, email, OR password are blank' do
    visit new_user_path
    expect(page).to have_text('Create Your Account')

    within('#new_user') do
      fill_in "Full Name", with: "Vane"
      fill_in "Password",  with: "vane.uniq"
      click_button "Create Account"
    end

    expect(page).to have_text('Create Your Account')
    expect(page).to have_text("Email can't be blank")
  end

  it 'asks for an optional display name, does not error if left blank'

end
