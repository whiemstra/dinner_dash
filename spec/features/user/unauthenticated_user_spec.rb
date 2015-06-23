require 'rails_helper'

describe 'unauthenticated user', type: :feature do

  before(:each) do
    @dummy_category = FactoryGirl.create(:category)
    @item1 = Item.create(title: "Item #1", description: "food", price: 10, categories: [@dummy_category])
    @item2 = Item.create(title: "Item #2", description: "wine", price: 12, categories: [@dummy_category])
    @item3 = Item.create(title: "Item #3", description: "beer", price: 5, categories: [@dummy_category])

    visit items_path
  end

  it 'can browse all items on home page' do
    expect(current_path).to eq(items_path)
    expect(page).to have_text("All Items")
    expect(page).to have_content("Item #1")
    expect(page).to have_content("Item #2")
    expect(page).to have_content(5)
  end

  it "visits the items page when that item title is clicked" do
    visit items_path
    click_on('Item #2')

    expect(current_path).to eq(item_path(@item2))
    expect(page).to have_text('Item #2')
    expect(page).to have_text(12)
  end

  it 'can browse items by a category' do
    category = FactoryGirl.create(:category, title: "Category Name")
    Item.create!(title: "Item Title #38", description: "slammin' description here", price: 5, categories: [category])


    visit root_path
    click_on "Category Name"

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content("slammin' description here")
    expect(page).to have_content("Item Title #38")
  end


end
