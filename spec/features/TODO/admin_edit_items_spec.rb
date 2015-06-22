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
    @item2 = Item.create(title: "Item #2", description: "item description #2", price: 40)
    @item3 = Item.create(title: "Item #3", description: "item description #3", price: 60)
    category = Category.create(title: "Category Name")
    category.items.create(title: "Item Title #4", description: "description for item #4 here", price: 5 )

  end

  it 'allows changing the title, description, price, and/or category' do
    expect(current_path).to eq(admin_path)
    click_on "Items"
    expect(page).to have_button('Edit Item')
    first(:button, "Edit Item").click

    fill_in('Title',       with: 'Item #4')
    fill_in('Description', with: 'Better description')
    fill_in('Price',       with: 17)
    find(:xpath, "//input[@value='Category Name']").set(true)
    click_on('Update')

    expect(page).to have_no_text('Item #1')
    expect(page).to have_text('Item #4')
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



  # before(:each) do
  #   @admin = User.create(full_name: "Admin",
  #     email: "admin@email.com",
  #     role: 1, password: "dinnerdash")
  #   visit root_path
  #   click_on("Toggle navigation")
  #   find('.dropdown-menu').click
  #   fill_in('Email', with: @admin.email)
  #   fill_in('Password', with: 'dinnerdash')
  #   click_on "Login"
  #
  #   click_on 'Categories'
  #   click_link('Create Category')
  #   fill_in("Title", with: "Category Title #1")
  #   click_on "Create Category"
  # end
  # it "categories can be added to an idea" do
  #   admin = create(:admin_user)
  #   item = create(:item)
  #   category = create(:category)
  #   category1 = create(:category1)
  #   category2 = create(:category2)
  #   category3 = create(:category3)
  #
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #   visit edit_admin_item_path(item)
  #
  #   fill_in "Item title", with: "Edited Item"
  #   fill_in "Item description", with: "Edited Description"
  #   fill_in "Price", with: 60
  #   page.check("curries")
  #   page.check("breakfast")
  #   click_button "Submit Item"
  #
  #   expect(page).to have_content("Edited Item")
  #   expect(page).to have_content("curries")
  #   expect(page).to have_content("breakfast")
  # end

