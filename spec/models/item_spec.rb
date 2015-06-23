require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { Item.create(title: "Item #1", description: "Item Description", price: 23) }

  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:price)}


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

  # Relationships

  it 'belongs to a category' do
    expect(item).to respond_to(:categories)
    expect(item).to respond_to(:categories=)

    item.categories = category
    expect(item.category_id).to eql(category.id)
  end

  xit 'can belong to more than one category' do
    item.category = category
    expect(item).to be_valid

  end

  xit 'must belong to at least one category to be valid' do
    item.category = nil
    expect(item).to be_invalid
    item.category = category
    expect(item).to be_valid
  end

  # ---

  it 'belongs to a user'

  it 'must belong to a user to be valid'

end
