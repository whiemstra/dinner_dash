require 'rails_helper'

RSpec.describe 'Admin Login', type: :feature do
  context "with valid attributes (admin role)" do
    before(:each) do
    @admin = User.create(full_name: "Whitney",
                        display_name: "Whit",
                        email: "whit@email.com",
                        role: 1,
                        password: "pa$$word")
    end

    it "can login as admin user and is taken to admin dashboard after login" do
      visit root_path

      click_on("Toggle navigation")
      find('.dropdown-menu').click

      fill_in "Email", with: @admin.email
      fill_in "Password", with: "pa$$word"
      click_button "Login"

      expect(current_path).to eq(admin_path)
      expect(page).to have_content("Admin Dashboard")
    end
  end


  context "with invalid attributes (non-admin role)" do
    before(:each) do
      @user = User.create(full_name: "Tom Petty",
                          display_name: "Tom",
                          email: "petty@email.com",
                          password: "freefallin")
    end

    it "is taken to admin dashboard after login" do
      visit root_path

      click_on("Toggle navigation")
      find('.dropdown-menu').click

      fill_in "Email", with: @user.email
      fill_in "Password", with: "freefallin"
      click_button "Login"

      expect(current_path).to eq(items_path)
      expect(page).to have_content("All Items")
    end
  end
end
