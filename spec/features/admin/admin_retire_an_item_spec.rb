require 'rails_helper'

describe 'Admin can retire an existing item', type: :feature do

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

  it 'allows an item to be deleted' do
    click_on "Items"

    click_on "Delete Item"

    expect(current_path).to eq(items_path)
    expect(page).not_to have_text("Item #1")
  end

  it 'allows an item to be retired' do
    click_on "Items"

    click_on "Edit Item"

    expect(current_path).to eq(edit_admin_items_path(@item1))
    expect(page).to have_content("Item #1")

    page.check "Unavailable"
  end

  it 'prevents retired items form being viewed on items page by regular user'

end
