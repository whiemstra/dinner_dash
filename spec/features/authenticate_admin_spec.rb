require 'rails_helper'

describe 'authenticated admin user', type: :feature do

  before(:each) do
    User.create(full_name: "vanessa", display_name: "admin", email: "admin@email.com", role: 1, password: "dinnerdash")
  end

  it 'can login as an admin' do
    visit root_path

    click_on("Toggle navigation")
    find('.dropdown-menu').click

    page.fill_in('Email', with: 'admin@email.com')
    page.fill_in('Password', with: 'dinnerdash')
    click_on "Login"

    expect(page).to have_content("Admin Dashboard")
    expect(current_path).to eq(admin_path)

  end
end

