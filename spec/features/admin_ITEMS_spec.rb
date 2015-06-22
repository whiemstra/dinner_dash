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

    it "can create a new item" do
      visit admin_path
      click_on "Items"
      click_link "Add New Item"

      expect(current_path).to eq(new_admin_item_path)

      fill_in "Item title", with: "New Item"
      fill_in "Item description", with: "New Description"
      fill_in "Price", with: 500
      page.check("Category #1")
      click_button "Create New Item"

      expect(page).to have_content("curries")
      expect(page).to have_content("breakfast")
      expect(page).to have_content("New Item")
      expect(page).to have_content("New Description")
      expect(page).to have_content(5)
      visit admin_items_path

      expect(page).to have_content("New Item")
    end
  end
  #
  # require "rails_helper"
  #
  # RSpec.describe "Admin items" do
  #
  #   context "as an admin" do
  #     it "can create a new item" do
  #       admin = create(:admin_user)
  #       category = create(:category)
  #       category1 = create(:category1)
  #       category2 = create(:category2)
  #       category3 = create(:category3)
  #
  #       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       expect(current_path).to eq(new_admin_item_path)
  #
  #       fill_in "Item title", with: "New Item"
  #       fill_in "Item description", with: "New Description"
  #       fill_in "Price", with: 500
  #       page.check("curries")
  #       page.check("breakfast")
  #       click_button "Submit Item"
  #       expect(page).to have_content("curries")
  #       expect(page).to have_content("breakfast")
  #       expect(page).to have_content("New Item")
  #       expect(page).to have_content("New Description")
  #       expect(page).to have_content(5)
  #       visit admin_items_path
  #
  #       expect(page).to have_content("New Item")
  #     end
  #
  #     it "cannot create a new item with empty title" do
  #       admin = create(:admin_user)
  #       category = create(:category)
  #       category1 = create(:category1)
  #       category2 = create(:category2)
  #       category3 = create(:category3)
  #
  #       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       expect(current_path).to eq(new_admin_item_path)
  #
  #       fill_in "Item title", with: ""
  #       fill_in "Item description", with: "New Description"
  #       fill_in "Price", with: 500
  #       page.check("curries")
  #       page.check("breakfast")
  #       click_button "Submit Item"
  #
  #       expect(page).to have_content("Title can't be blank")
  #     end
  #
  #     it "can not create the same item twice" do
  #       admin = create(:admin_user)
  #       category = create(:category)
  #       category1 = create(:category1)
  #       category2 = create(:category2)
  #       category3 = create(:category3)
  #
  #       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       expect(current_path).to eq(new_admin_item_path)
  #
  #       fill_in "Item title", with: "New Item"
  #       fill_in "Item description", with: "New Description"
  #       fill_in "Price", with: 500
  #       page.check("curries")
  #       page.check("breakfast")
  #       click_button "Submit Item"
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       expect(current_path).to eq(new_admin_item_path)
  #
  #       fill_in "Item title", with: "New Item"
  #       fill_in "Item description", with: "New Description"
  #       fill_in "Price", with: 500
  #       page.check("curries")
  #       page.check("breakfast")
  #       click_button "Submit Item"
  #
  #       expect(page).to have_content("Title has already been taken")
  #     end
  #
  #     it "can not create the same item twice" do
  #       admin = create(:admin_user)
  #       category = create(:category)
  #       category1 = create(:category1)
  #       category2 = create(:category2)
  #       category3 = create(:category3)
  #
  #       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       expect(current_path).to eq(new_admin_item_path)
  #
  #       fill_in "Item title", with: "New Item"
  #       fill_in "Item description", with: "New Description"
  #       fill_in "Price", with: 500
  #       page.check("curries")
  #       page.check("breakfast")
  #       click_button "Submit Item"
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       expect(current_path).to eq(new_admin_item_path)
  #
  #       fill_in "Item title", with: "New Item"
  #       fill_in "Item description", with: "New Description"
  #       fill_in "Price", with: 500
  #       page.check("curries")
  #       page.check("breakfast")
  #       click_button "Submit Item"
  #
  #       expect(page).to have_content("Title has already been taken")
  #     end
  #   end
  # end
  #
  # require "rails_helper"
  #
  # RSpec.describe "Admin Items" do
  #   context "edit item" do
  #     it "can edit an item" do
  #       5.times do |x|
  #         create(:item, title: "Item#{x}")
  #       end
  #
  #       admin = create(:admin_user)
  #       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #       visit admin_dashboard_path
  #
  #       within(".admin-links") do
  #         click_link "All Items"
  #       end
  #
  #       expect(current_path).to eq(admin_items_path)
  #
  #       click_link "Item1"
  #       click_link "Edit"
  #
  #       fill_in "Item title", with: "Edited Item"
  #       fill_in "Item description", with: "Edited Description"
  #       fill_in "Price", with: 600
  #       click_button "Submit Item"
  #
  #       expect(page).to have_content("Edited Item")
  #       expect(page).to have_content("Edited Description")
  #       expect(page).to have_content(6)
  #     end
  #
  #     it "can not change the item title to an already existing title" do
  #       admin = create(:admin_user)
  #       category = create(:category)
  #       category1 = create(:category1)
  #       category2 = create(:category2)
  #       category3 = create(:category3)
  #
  #       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       expect(current_path).to eq(new_admin_item_path)
  #
  #       fill_in "Item title", with: "New Item"
  #       fill_in "Item description", with: "New Description"
  #       fill_in "Price", with: 500
  #       page.check("curries")
  #       page.check("breakfast")
  #       click_button "Submit Item"
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       visit admin_dashboard_path
  #       click_link "Add New Item"
  #
  #       expect(current_path).to eq(new_admin_item_path)
  #
  #       fill_in "Item title", with: "New Item2"
  #       fill_in "Item description", with: "New Description"
  #       fill_in "Price", with: 500
  #       page.check("curries")
  #       page.check("breakfast")
  #       click_button "Submit Item"
  #
  #       visit admin_items_path
  #       click_link "New Item"
  #       click_link "Edit"
  #
  #       fill_in "Item title", with: "New Item2"
  #       fill_in "Item description", with: "Edited Description"
  #       fill_in "Price", with: 600
  #       click_button "Submit Item"
  #
  #       expect(page).to have_content("Title has already been taken")
  #     end
  #   end
  # end
  #
  # require "rails_helper"
  #
  # RSpec.describe "admin capabilities" do
  #   context "as admin" do
  #     it "can retire an item" do
  #       5.times do |x|
  #         create(:item, title: "Item#{x}")
  #       end
  #
  #       admin = create(:admin_user)
  #
  #       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #       visit admin_dashboard_path
  #
  #       within(".admin-links") do
  #         click_link "All Items"
  #       end
  #
  #       expect(current_path).to eq(admin_items_path)
  #
  #       click_link "Item1"
  #       click_link "Edit"
  #
  #       page.choose "item[status]", match: :first
  #       click_button "Submit Item"
  #
  #       expect(page).to have_content("retired")
  #     end
  #   end
  # end
  #

end

