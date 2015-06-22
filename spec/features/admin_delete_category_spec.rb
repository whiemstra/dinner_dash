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

    it 'deletes a category' do
      click_on 'Categories'
      click_link('Create Category')
      fill_in('Title', with: 'Category Title 2')
      click_button('Create Category')

      click_link "Delete"

      expect(page).to_not have_content('Category Title 2')
      expect(current_path).to eq(admin_categories_path)
    end

  end
end
