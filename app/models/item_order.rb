class ItemOrder < ActiveRecord::Base
  belongs_to :item
  belongs_to :order
  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true

  def subtotal
    quantity * item.price
  end
end
