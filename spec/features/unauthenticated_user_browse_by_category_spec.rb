require 'rails_helper'

describe 'unauthenticated user', type: :feature do
  it 'can browse items by category' do
    Category.create(title: "Desserts")
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Desserts")
  end

  it 'can select a category from the menu' do
    category = Category.create(title: "Desserts")
    item = category.items.create(title: "Fried Oreo", description: "Deep fried oreo", price: 5 )
    visit root_path
    click_on "Desserts"

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content("Desserts")
    expect(page).to have_content("Fried Oreo")
  end
end
