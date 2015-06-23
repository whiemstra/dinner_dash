require 'rails_helper'

describe 'admin', type: :feature do

  before(:each) do
    User.create(full_name: "vanessa", display_name: "admin", email: "admin@email.com", role: 1, password: "dinnerdash")
    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click
    page.fill_in('Email', with: 'admin@email.com')
    page.fill_in('Password', with: 'dinnerdash')
    click_on "Login"
    visit admin_path
  end

  it 'creates new categories' do
    page.click_on 'Categories'
    find('.create-category').click
    page.fill_in('Title', with: 'Category 1')
    page.click_button('Create Category')
    expect(page).to have_content('Category 1')
    expect(current_path).to eq(admin_categories_path)
  end

  it 'edits a category' do
    page.click_on 'Categories'
    find('.create-category').click
    page.fill_in('Title', with: 'Category 1')
    page.click_button('Create Category')

    click_link "Edit"
    fill_in('Title', with: 'Category 5')
    click_button('Update Category')
    expect(page).to have_content('Category 5')
    expect(current_path).to eq(admin_categories_path)
  end


  it 'deletes a category' do
    page.click_on 'Categories'
    find('.create-category').click
    page.fill_in('Title', with: 'Category 1')
    page.click_button('Create Category')

    click_link "Delete"
    expect(page).to_not have_content('Category 1')
    expect(current_path).to eq(admin_categories_path)
  end
end
