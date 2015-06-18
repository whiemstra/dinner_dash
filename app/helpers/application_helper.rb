module ApplicationHelper

  def to_dollars(price)
    number_to_currency(price)
  end



  # TODO need to work on if we want cents
  # def to_dollars(number, options = {})
  #   options = options.stringify_keys
  #   precision = options.delete('precision') { 2 }
  #   unit = options.delete('unit') { '$' }
  #   fractional_unit = options.delete('fractional_unit') { '¢' }
  #   separator = options.delete('separator') { '.' }
  #   delimiter = options.delete('delimiter') { ',' }
  #   separator = '' unless precision > 0
  #   begin
  #     fraction = number.abs % 1.0
  #     body = number.floor
  #     if body != 0 || body == 0 && fraction == 0 then
  #       parts = number_with_precision(number, precision).split('.')
  #       unit + number_with_delimiter(parts[0], delimiter) + separator + parts[1].to_s
  #     else
  #       (fraction * 100).to_i.to_s + fractional_unit
  #     end
  #   rescue
  #     number
  #   end
  # end
end
