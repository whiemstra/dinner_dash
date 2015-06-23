require "rails_helper"

RSpec.describe "Admin view" do
  before(:each) do
    @admin = User.create(full_name: "Whitney",
                          display_name: "Whit",
                          email: "whit@email.com",
                          role: 1,
                          password: "pa$$word")
    visit root_path

    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @admin.email
    fill_in "Password", with: "pa$$word"
    click_button "Login"

    category1 = FactoryGirl.create(:category, title: "Category #1")
    category2 = FactoryGirl.create(:category, title: "Category #2")
    Item.create!(title: "Item Title #1", description: "description for item #1 here", price: 2500, categories: [category1])
    Item.create!(title: "Item Title #2", description: "description for item #2 here", price: 500, categories: [category2])
    Item.create!(title: "Item Title #3", description: "description for item #3 here", price: 1700, categories: [category2])
  end

  it "can view all items" do
    expect(current_path).to eq(admin_path)
    expect(page).to have_content("Admin Dashboard")

    click_on "Items"
    expect(page).to have_content("All Items")
    expect(page).to have_content("Item Title #1")
    expect(page).to have_content("Item Title #2")
    expect(page).to have_content("Item Title #3")

  end

end
