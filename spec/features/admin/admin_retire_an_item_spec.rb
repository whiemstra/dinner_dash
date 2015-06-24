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

    category1 = FactoryGirl.create(:category, title: "Category #1")
    category2 = FactoryGirl.create(:category, title: "Category #2")
    @item1 = Item.create!(title: "Item Title #1", description: "description for item #1 here", price: 2500, categories: [category1])
    @item2 = Item.create!(title: "Item Title #2", description: "description for item #2 here", price: 500, categories: [category2])
  end

  it 'can retire and then un-retire an existing item' do
    click_on "Items"
    click_link "Item Title #1"

    expect(page).to have_content("< Back to All Items")
    expect(page).to have_button("Edit Item")

    click_on "Edit Item"
    expect(current_path).to eq(edit_admin_item_path(@item1))

    uncheck('Available?')
    click_on "Update"

    expect(page).to have_no_content("Add to Cart")

    click_on "Edit Item"
    check('Available?')
    click_on "Update"

    expect(page).to have_button("Add to Cart")

  end

end
