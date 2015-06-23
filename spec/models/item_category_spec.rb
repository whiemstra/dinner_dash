require 'rails_helper'

RSpec.describe ItemCategory, type: :model do
  let(:category_1) { Category.create(title: "Appetizers") }
  let(:category_2) { Category.create(title: "Desserts") }
  let(:item_1) { Item.create(title: "French Fries", description: "Very French", price: 5) }
  let(:item_2) { Item.create(title: "Fried Oreo", description: "Milk's favorite cookie", price: 5) }

  it "responds to items" do
    expect(category_1).to respond_to(:items)
    expect(category_2).to respond_to(:items)
  end

  it "responds to categories" do
    expect(item_1).to respond_to(:categories)
    expect(item_2).to respond_to(:categories)
  end

  it "has an item associated with a category" do
    ItemCategory.create(item_id: item_1.id, category_id: category_1.id)
    ItemCategory.create(item_id: item_2.id, category_id: category_2.id)

    item_1.categories << category_1
    item_2.categories << category_2

    expect(item_1.categories.last).to eq(category_1)
    expect(item_2.categories.last).to eq(category_2)
  end

  it "can add items to a category" do
    category_1.items.push(item_1).push(item_2)

    expect(category_1.items.count).to eq(2)
    expect(category_1.items.first).to eq(item_1)
  end
end
