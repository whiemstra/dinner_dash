require 'rails_helper'

describe 'Authenticated user', type: :feature do
  before(:each) do
    @category = FactoryGirl.create(:category)
    @item1 = Item.create!(title: "Item #1", description: "food", price: 8, categories: [@category], status: true)
    @item2 = Item.create!(title: "Item #2", description: "wine", price: 12, categories: [@category])
    @item3 = Item.create!(title: "Item #3", description: "beer", price: 5, categories: [@category])

    @user = User.create!(full_name: "Tom Petty",
                         email: "petty@gmail.com",
                         password: "freefallin")

    visit root_path
    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    first(:button, "Add to Cart").click
    first(:button, "Add to Cart").click

    click_on("Toggle navigation")
    find('#cart').click

    click_on "Checkout"

    click_on "Confirm"
  end

  it "can view past orders" do
    visit root_path
    click_on("Toggle navigation")
    click_link("View Past Orders")

    expect(page).to have_content("Past Orders")
    expect(page).to have_content("Item #1")
    expect(page).to have_content("$0.16")
    expect(current_path).to eq(user_orders_path)
  end

  it "can visit a retired item from a past order" do
    @item1.update(title: "Item #1", description: "food", price: 8, categories: [@category], status: false)

    visit root_path
    click_on("Toggle navigation")
    click_link("View Past Orders")
    click_link("Item #1")

    expect(page).to_not have_button("Add to Cart")
  end

end
