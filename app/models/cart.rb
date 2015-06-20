class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def total
    contents.values.sum
  end

  def count_of(item_id)
    contents[item_id.to_s]
  end

  def items
    contents
  end

  def increase_quantity(item_id)
    contents[item_id] += 1
  end

  def decrease_quantity(item_id)
    contents[item_id] -= 1 if contents[item_id] > 0
  end

  def find_valid_items
    items = subtotal.reject { |_id, total| total == 0}
    items.keys.map { |item_id| Item.find(item_id)}
  end

  def find_items
    contents.keys.map { |item_id| Item.find(item_id)}
  end

  def subtotal
    find_items.each_with_object({}) do |item, hash|
      hash[item.id] = count_of(item.id.to_s) * item.price
    end
  end

  def create_item_orders(order_id)
    contents.find_items.each do
      ItemOrders.new()
    end
  end

  def clear
    contents.clear
  end

end
