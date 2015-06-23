require 'rails_helper'

describe 'Admin', type: :feature do

  before(:each) do
    @admin = User.create(full_name: "Tom Petty",
                          email: "petty@gmail.com",
                          role: 1,
                          password: "freefallin")
    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @admin.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    @item1 = Item.create(title: "Item #1", description: "item description #1", price: 20)
  end

  it 'can retire an existing item' do
    click_on "Items"
    expect(page).to have_content("Item #1")

    click_link "Item #1"
    expect(page).to have_button("Edit Item")

    click_on "Edit Item"

    expect(current_path).to eq(edit_admin_item_path(@item1))
    uncheck('Available?')
    click_on "Update"

    expect(page).to have_content("Current Status: unavailable")

  end

  it 'prevents retired items form being viewed on items page by regular user'

end
