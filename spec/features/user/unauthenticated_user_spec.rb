require 'rails_helper'

describe 'unauthenticated user', type: :feature do

  before(:each) do
    @item1 = Item.create(title: "Item #1", description: "food", price: 10)
    @item2 = Item.create(title: "Item #2", description: "wine", price: 12)
    @item3 = Item.create(title: "Item #3", description: "beer", price: 5)
  end

  it 'can browse all items on home page' do
    visit items_path
    expect(current_path).to eq(items_path)
    expect(page).to have_content("Item #1")
    expect(page).to have_content("Item #2")
    expect(page).to have_content(5)
  end

  it 'can browse items by a category' do
    category = Category.create(title: "Category Name")
    category.items.create(title: "Item Title #38", description: "slammin' description here", price: 5 )
    visit root_path
    click_on "Category Name"

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content("slammin' description here")
    expect(page).to have_content("Item Title #38")
  end

  it 'can add an item to my cart'

  it 'can view'

  it 'can remove an item from cart'

  it 'can increase the quantity of a item in my cart'

  it 'log in and cart does not get cleared'
end
