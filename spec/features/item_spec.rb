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

