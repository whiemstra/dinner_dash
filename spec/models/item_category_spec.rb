require 'rails_helper'

RSpec.describe ItemCategory, type: :model do
  let(:item_category) { ItemCategory.new }

  it { should validate_presence_of :item }
  it { should validate_presence_of :category }

  # xit 'has an item_id attribute' do
  #   expect(item_category).to respond_to(:item_id=)
  # end
  #
  # xit 'has an category_id attribute' do
  #   expect(item_category).to respond_to(:category_id=)
  # end
  #
  # xit 'requires an item_id and category_id to be valid' do
  #   expect(item_category).to_not be_valid
  #   item_category.item_id = 3
  #
  #   expect(item_category).to_not be_valid
  #
  #   item_category.category_id = 8
  #
  #   expect(item_category).to be_valid
  # end

end
