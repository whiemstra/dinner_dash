require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { Item.create(title: "Item #1", description: "Item Description", price: 23) }

  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:price)}

  it 'is valid' do
    expect(item).to be_valid
  end

end
