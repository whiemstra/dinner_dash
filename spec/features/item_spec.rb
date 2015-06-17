require 'rails_helper'

describe 'view an item', type: :feature do

  before(:each) do
    Item.create(title: "Fried Snack", description: "fatty food", price: 10)
  end

  it 'has items on items page' do
    visit items_path
    expect(page).to have_text("All Items")
    expect(page).to have_text("Fried Snack")
  end

  it "clicking items title will go to item page" do
    visit items_path
    click_on('Fried Snack')

    expect(current_path).to eq(item_path(Item.last))
    expect(page).to have_text('Fried Snack')
    expect(page).to have_text(10)
  end

end

describe 'creating a new item', type: :feature do

  it 'lets me create a new item' do

    visit new_item_path
    fill_in('Title', with: "Fried Oreos")
    fill_in('Description', with: "Literally fried Oreos")
    fill_in('Price', with: 3 )
    click_on "Create New Item"

    expect(current_path).to eq(item_path(Item.last))
    expect(page).to have_text("Fried Oreos")
  end

end

describe 'deleting an item', type: :feature do

  before(:each) do
    @item1 = Item.create(title: "Food", description: "fatty food", price: 10)
    @item2 = Item.create(title: "Drink", description: "wine", price: 10)
    @item3 = Item.create(title: "Alcohol", description: "beer", price: 10)
  end

  it 'allows an item to be deleted' do

    visit item_path(@item2)
    click_on "Delete Item"

    expect(current_path).to eq(items_path)
    expect(page).not_to have_text("Drink")
  end

end

