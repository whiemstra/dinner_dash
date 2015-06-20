require 'rails_helper'

describe 'unauthenticated user', type: :feature do

  it "add an item to cart_items" do
    @item = Item.create(title: "Item #1",
                        description: "Description of Item",
                        price: 1800)

    visit root_path
    click_on "Add to Cart"
    visit cart_items_path

    expect(page).to have_text('Item #1')
    expect(page).to have_text('$18.00')
  end

  it "removes an item from cart_items" do
    @item = Item.create(title: "Item #1", description: "Description of Item", price: 18)

    visit root_path
    click_on "Add to Cart"
    visit cart_items_path

    expect(page).to have_text('Item #1')
    click_on "Remove"
    expect(page).to have_text('You have removed Item #1 from your cart.')
  end

  it "views items in cart_items" do
    @item = Item.create(title: "Item #1",
                        description: "Description of Item",
                        price: 7800)

    visit root_path
    click_on "Add to Cart"
    click_on("Toggle navigation")
    find('#cart').click

    expect(current_path).to eq(cart_items_path)
    expect(page).to have_text('Item #1')
    expect(page).to have_text('$78.00')
  end

  it "updates quantity of item in cart" do
    @item = Item.create(title: "Item #1", description: "Description of Item", price: 18)

    visit root_path
    click_on "Add to Cart"
    click_on "Add to Cart"
    click_on("Toggle navigation")
    find('#cart').click

    expect(page).to have_text('2')
    click_on "-"
    expect(page).to have_text('1')
    click_on "+"
    click_on "+"
    click_on "+"
    expect(page).to have_text('4')
  end
end

describe 'authenticated user', type: :feature do
  before(:each) do
    @user = User.create(full_name: "Tom Petty",
                        display_name: "Tom",
                        email: "petty@gmail.com",
                        password: "freefallin")
    @item1 = Item.create(title: "Item #1", description: "food", price: 8)
    @item2 = Item.create(title: "Item #2", description: "wine", price: 12)
    @item3 = Item.create(title: "Item #3", description: "beer", price: 5)
  end

  it "can checkout" do

    visit root_path

    click_on("Toggle navigation")
    find('.dropdown-menu').click

    fill_in "Email", with: @user.email
    fill_in "Password", with: "freefallin"
    click_button "Login"

    expect(page).to have_content("Hello, Tom")

    first(:button, "Add to Cart").click
    click_on("Toggle navigation")
    find('#cart').click

    # click_on("Toggle navigation")
    # find('#cart').click

    expect(page).to have_content("Item #1")
    expect(page).to have_button("Checkout")

    click_button "Checkout"
    expect(page).to have_content("Confirm Your Order")
    click_button "Confirm Order"
    expect(page).to have_content("Would you like to pay now?")

    click_button "No thanks."
    expect(page).to have_content("Ordered Confirmed")
    expect(current_path).to eql(items_path)
  end

  xit "can not checkout without anything in cart" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit cart_items_path

    click_button "Place Order"

    expect(page).to have_content("Silly person...Cart can't be empty.")
  end

end
