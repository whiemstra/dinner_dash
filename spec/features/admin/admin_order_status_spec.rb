require "rails_helper"

RSpec.describe "Admin " do
  context "when logged in" do

    before(:each) do
      @admin = User.create(full_name: "Admin",
                           email: "admin@email.com",
                           role: 1,
                           password: "dinnerdash")
      visit root_path
      click_on("Toggle navigation")
      find('.dropdown-menu').click
      fill_in('Email', with: @admin.email)
      fill_in('Password', with: 'dinnerdash')
      click_on "Login"

      category1 = FactoryGirl.create(:category, title: "Category #1")
      category2 = FactoryGirl.create(:category, title: "Category #2")
      Item.create!(title: "Item Title #1", description: "description for item #1 here", price: 2500, categories: [category1])
      Item.create!(title: "Item Title #2", description: "description for item #2 here", price: 500, categories: [category2])
    end

    it "displays the orders current status" do
      visit items_path
      first(:button, "Add to Cart").click

      click_on("Toggle navigation")
      find('#cart').click

      click_button "Checkout"
      click_button "Confirm Order"

      visit admin_path
      expect(page).to have_content("ordered")
      expect(page).to have_content('$25.00')
    end

    it "can change status of an individual order" do
      visit items_path
      first(:button, "Add to Cart").click

      click_on("Toggle navigation")
      find('#cart').click

      click_button "Checkout"
      click_button "Confirm Order"

      visit admin_path
      expect(page).to have_content("ordered")

      find('.dropdown-menu').click
      click_on("Cancelled")

      expect(page).to have_content("cancelled")
      expect(page).to_not have_content("ordered")
    end
  end
end

