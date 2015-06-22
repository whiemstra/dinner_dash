require "rails_helper"

RSpec.describe "Admin can add categories to idea" do
  context "by editting the item" do
    it "categories can be added to an idea" do
      admin = create(:admin_user)
      item = create(:item)
      category = create(:category)
      category1 = create(:category1)
      category2 = create(:category2)
      category3 = create(:category3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_item_path(item)

      fill_in "Item title", with: "Edited Item"
      fill_in "Item description", with: "Edited Description"
      fill_in "Price", with: 60
      page.check("curries")
      page.check("breakfast")
      click_button "Submit Item"

      expect(page).to have_content("Edited Item")
      expect(page).to have_content("curries")
      expect(page).to have_content("breakfast")
    end

  end

end
