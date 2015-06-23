require 'rails_helper'

describe 'Authenticated user', type: :feature do
  before(:each) do
    @category = FactoryGirl.create(:category)
    @item1 = Item.create!(title: "Item #1", description: "food", price: 8, categories: [@category])
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
  end

  it "can checkout" do
    expect(page).to have_content("Hello, Tom Petty!")
    first(:button, "Add to Cart").click
    first(:button, "Add to Cart").click
    expect(page).to have_content("You now have 2 Item #1s in your cart.")

    click_on("Toggle navigation")
    find('#cart').click

    expect(page).to have_content(16)
    expect(page).to have_button("Checkout")

    click_on "Checkout"

    expect(page).to have_content("Confirm Your Order")
    click_on "Confirm"

    expect(page).to have_content("Order Placed!")
  end

  it "can not checkout without anything in cart" do
    expect(page).to have_content("Hello, Tom Petty!")

    click_on("Toggle navigation")
    find('#cart').click

    click_on "Checkout"

    expect(page).to have_content("Silly Shopper...There was nothing in your cart to purchase.")
  end
end

