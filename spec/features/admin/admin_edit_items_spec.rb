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

    category1 = Category.create(title: "Category #1")
    category2 = Category.create(title: "Category #2")
    category1.items.create(title: "Item Title #1", description: "description for item #1 here", price: 2500 )
    category1.items.create(title: "Item Title #2", description: "description for item #2 here", price: 500 )

  end

  it 'can edit an existing item by changing the title, description, price, and/or category' do
    expect(current_path).to eq(admin_path)
    click_on "Items"
    click_link "Item Title #1"
    first(:button, "Edit Item").click

    fill_in('Title',       with: 'Item Title #4')
    fill_in('Description', with: 'Better description')
    fill_in('Price',       with: 17)

    uncheck("Category #1")
    check("Category #2")
    click_on('Update')

    expect(page).to have_no_text('Item Title #1')
    expect(page).to have_text('Item Title #4')
    expect(page).to have_no_text('sweet item description')
    expect(page).to have_text('Better description')
    expect(page).to have_no_text(10)
    expect(page).to have_text(17)
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
