class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :item_orders
  has_many   :items, through: :item_orders

  validates :user_id, presence: true
  validates :subtotal, presence: true
  validates :status, presence: true

  enum status: %w(ordered completed cancelled paid)###################

  default_scope { order(created_at: :desc)}

  def self.number_ordered
    ordered.count
  end

  def self.number_completed
    completed.count
  end

  def self.number_cancelled
    cancelled.count
  end

  def total
    subtotal
  end

  def order_status
    if status == "ordered"
      status
    else
      "#{status} -  updated on: #{self.updated_at.strftime("%b %e %Y %l:%M %p")}"
    end
  end

  def date_created
    created_at.strftime("%b %e %Y %l:%M %p")
  end

  def date_updated
    updated_at.strftime("%b %e %Y %l:%M %p")
  end

end
