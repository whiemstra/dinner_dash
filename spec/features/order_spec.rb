require 'rails_helper'

describe 'unauthenticated user', type: :feature do

  it "add an item to cart_items" do
    @item = Item.create(title: "Item #1", description: "Description of Item", price: 18)

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
    @item = Item.create(title: "Item #1", description: "Description of Item", price: 18)

    visit root_path
    click_on "Add to Cart"
    click_on("Toggle navigation")
    find('#cart').click

    expect(current_path).to eq(cart_items_path)
    expect(page).to have_text('Item #1')
    expect(page).to have_text('$18.00')
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
