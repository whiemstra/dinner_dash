require 'rails_helper'

describe 'Admin can delete an existing item', type: :feature do

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
    @item2 = Item.create(title: "Item #2", description: "item description #2", price: 40)
    @item3 = Item.create(title: "Item #3", description: "item description #3", price: 60)
    category = Category.create(title: "Category Name")
    category.items.create(title: "Item Title #4", description: "description for item #4 here", price: 5 )

  end

  it 'allows an item to be deleted' do
    expect(current_path).to eq(admin_path)
    click_on "Items"
    expect(page).to have_button('Delete Item')
    first(:button, "Delete Item").click

    expect(current_path).to eq(admin_items_path)
    expect(page).not_to have_text("Item #1")
    expect(page).to have_text("Item was successfully deleted")
  end

  it 'blocks a unauthenticated admin user from deleting an item' do
    click_on("Toggle navigation")
    click_on "Log out"

    expect(page).to_not have_content('Admin Dashboard')
    expect(page).to_not have_content('Delete Item')

    visit admin_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
