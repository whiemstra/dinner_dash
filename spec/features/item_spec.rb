require 'rails_helper'

describe 'view an item', type: :feature do

  it 'has items on items page' do
    visit items_path
    expect(page).to have_text("All Items")
  end

end

describe 'creating a new item', type: :feature do

  it 'lets me create a new item' do

    visit new_item_path
    fill_in('Title', with: "Fried Oreos")
    fill_in('Description', with: "Literally fried Oreos")
    fill_in('Price', with: 3 )
    click_on "Create New Item"

    #expect(current_path).to eq(items_path(@item))
    expect(page).to have_text("Fried Oreos")
  end

end

