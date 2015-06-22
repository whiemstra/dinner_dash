require 'rails_helper'

RSpec.describe "Admin Categories" do
  context "with a logged in admin" do
    before(:each) do
      @admin = User.create(full_name: "Admin",
                           email: "admin@email.com",
                           role: 1, password: "dinnerdash")
      visit root_path
      click_on("Toggle navigation")
      find('.dropdown-menu').click
      fill_in('Email', with: @admin.email)
      fill_in('Password', with: 'dinnerdash')
      click_on "Login"
    end

    it 'creates new category' do
      click_on 'Categories'
      click_link('Create Category')
      fill_in('Title', with: 'Category 1')
      click_button('Create Category')

      expect(page).to have_content('Category 1')
      expect(current_path).to eq(admin_categories_path)
    end

    it "cannot create duplicate categories" do
      click_on 'Categories'
      click_link('Create Category')
      fill_in("Title", with: "Category Title")
      click_on "Create Category"

      click_link "Create Category"
      fill_in "Title", with: "Category Title"
      click_on "Create Category"
      expect(page).to have_content("Title has already been taken")
    end

    it "cannot create a category that is blank" do
      click_on 'Categories'
      click_link('Create Category')
      fill_in('Title', with: "")
      click_on('Create Category')
      expect(page).to have_content("Title can't be blank")
    end
  end
end
