require 'rails_helper'

describe 'admin categories', type: :feature do

  before(:each) do
    User.create(full_name: "vanessa", display_name: "admin", email: "admin@email.com", role: 1, password: "dinnerdash")
    visit login_path
    click_on "Sign Up/Login"
    page.fill_in('Email', with: 'admin@email.com')
    page.fill_in('Password', with: 'dinnerdash')
    click_on "Log in"
    visit admin_categories_path
  end

  it 'creates new categories' do
    page.click_link 'Create Category'
    page.fill_in('Title', with: 'Category 1')
    page.click_button('Create Category')
    expect(page).to have_content('Category 1')
    expect(current_page).to eq(admin_categories_path)
  end

  it 'edits a category' do
    page.click_link 'Create Category'
    page.fill_in('Title', with: 'Category 1')
    page.click_button('Create Category')
    expect(page).to have_content('Category 1')
    expect(current_page).to eq(admin_categories_path)
  end
end
