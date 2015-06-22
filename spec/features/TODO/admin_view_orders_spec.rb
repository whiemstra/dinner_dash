require "rails_helper"

RSpec.describe "Admin" do
  context "when visiting the orders page" do

    it "can see all orders" do
      admin = create(:admin_user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      5.times do |x|
        create(:item, title: "item#{x}")
      end

      visit items_path
      click_link "item1"
      first(:button, "Add To Cart").click

      visit items_path
      click_link "item2"
      first(:button, "Add To Cart").click

      visit checkout_path

      click_button "Checkout"
      click_button "Confirm"

      visit admin_orders_dashboard_path
      expect(page).to have_content("Order Dashboard")
      expect(page).to have_content("Order_id")
      expect(page).to have_content("User_id")
      expect(page).to have_content("ordered")
      expect(page).to have_content("Canceled")
      expect(page).to have_content("Completed")
    end
  end
end
