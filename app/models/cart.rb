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

end
