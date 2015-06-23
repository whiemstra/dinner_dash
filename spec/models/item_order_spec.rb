require 'rails_helper'

describe ItemOrder, type: :model do

  it {should validate_presence_of :item_id}
  it {should validate_presence_of :order_id}
  it {should validate_presence_of :quantity}

end
