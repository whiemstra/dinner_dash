module ApplicationHelper

  def to_dollars(price)
    number_to_currency(price, :unit => "$")
  end

end
