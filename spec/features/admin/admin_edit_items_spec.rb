require 'rails_helper'

describe 'Admin can edit an existing item', type: :feature do

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
    category1 = Category.create(title: "Category #1")
    category2 = Category.create(title: "Category #2")
    category1.items.create(title: "Item Title #4", description: "description for item #4 here", price: 5 )

  end

  it 'allows changing the title, description, price, and/or category' do
    expect(current_path).to eq(admin_path)
    click_on "Items"
    expect(page).to have_button('Edit Item')
    first(:button, "Edit Item").click

    fill_in('Title',       with: 'Item #4')
    fill_in('Description', with: 'Better description')
    fill_in('Price',       with: 17)
    page.check("category #1")
    page.check("category #2")
    click_on('Update')

    expect(page).to have_no_text('Item #1')
    expect(page).to have_text('Item #4')
    expect(page).to have_no_text('sweet item description')
    expect(page).to have_text('Better description')
    expect(page).to have_no_text(10)
    expect(page).to have_text(17)
    expect(page).to have_content("category #2")
    expect(page).to_not have_content("category #1")
  end

  it 'blocks a unauthenticated admin user from editing an item' do
    click_on("Toggle navigation")
    click_on "Log out"

    expect(page).to_not have_content('Admin Dashboard')
    expect(page).to_not have_content('Edit Item')

    visit admin_path
    expect(page).to have_content("The page you were looking for doesn't exist.")

  end
end
