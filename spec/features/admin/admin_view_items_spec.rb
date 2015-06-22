require "rails_helper"

RSpec.describe "Admin view" do
  before(:each) do
    @item1 = Item.create(title: "Item #1", description: "item description #1", price: 20)
    @item2 = Item.create(title: "Item #2", description: "item description #2", price: 40)
    @item3 = Item.create(title: "Item #3", description: "item description #3", price: 60)

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
  end

  it "can view all items" do
    expect(current_path).to eq(admin_path)
    expect(page).to have_content("Admin Dashboard")

    click_on "Items"
    expect(page).to have_content("All Items")
    expect(page).to have_content("Item #1")
    expect(page).to have_content("Item #2")
    expect(page).to have_content("Item #3")

  end

end
