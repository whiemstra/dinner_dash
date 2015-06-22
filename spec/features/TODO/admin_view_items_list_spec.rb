require "rails_helper"

RSpec.describe "admin items" do
  context "when logged in as admin" do
    it "can view list of items" do
      5.times do |x|
        create(:item, title: "Item#{x}")
      end

      admin = create(:admin_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      within(".admin-links") do
        click_link "All Items"
      end

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Item0")
      expect(page).to have_content("Item4")
      expect(page).to have_content("Item3")
      expect(page).to have_content("Item2")
      expect(page).to have_content("Item1")
    end
  end
end
