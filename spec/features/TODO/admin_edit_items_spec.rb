require "rails_helper"

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

      click_on 'Categories'
      click_link('Create Category')
      fill_in("Title", with: "Category Title #1")
      click_on "Create Category"
    end
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
