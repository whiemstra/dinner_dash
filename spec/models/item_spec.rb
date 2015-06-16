require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { Item.create(title: "Fried Snack", description: "fatty food", price: 10) }

  it 'is valid' do
    expect(item).to be_valid
  end

  it 'needs a title to be valid' do
    item.title = nil
    expect(item).to_not be_valid
  end

  it 'needs a description to be valid'do
    item.description = nil
    expect(item).to_not be_valid
  end

  it 'needs a price to be valid' do
    item.price = nil
    expect(item).to_not be_valid
  end



end
