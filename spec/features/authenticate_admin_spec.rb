require 'rails_helper'

describe 'authenticated admin user', type: :feature do

  before(:each) do
    User.create(full_name: "vanessa", display_name: "admin", email: "admin@email.com", role: 1, password: "dinnerdash")
    visit login_path
  end

  it 'can login as an admin' do
    page.fill_in('Email', with: 'admin@email.com')
    page.fill_in('Password', with: 'dinnerdash')
    click_on "Log in"

    expect(page).to have_content("Admin Dashboard")
    expect(current_path).to eq(admin_path)
  end
end

