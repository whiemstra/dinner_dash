require "rails_helper"

RSpec.describe "Admin Order Page" do
  context "with a logged in admin" do

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

      category = Category.create(title: "Drinks")
      item1 = Item.create(title: "Wine", description: "Pinot Noir", price: 10)
      item1.item_categories.create(category: category)
    end

    it "displays the orders current status" do
      visit items_path
      click_on "Add to Cart"

      click_on("Toggle navigation")
      find('#cart').click

      click_button "Checkout"
      click_button "Confirm Order"

      visit admin_path
      expect(page).to have_content("ordered")
      expect(page).to have_content(10)
    end

    xit "can change status of an individual order" do
      visit items_path
      click_on "Add to Cart"

      click_on("Toggle navigation")
      find('#cart').click

      click_button "Checkout"
      click_button "Confirm Order"

      visit admin_path
      expect(page).to have_content("ordered")
      # select("cancelled", from: ###DROP DOWN MENU)

      expect(page).to have_content("cancelled")
      expect(page).to_not have_content("ordered")
    end
  end
end

