class Item < ActiveRecord::Base
  validates :title, presence: true,
            uniqueness: true
  validates_presence_of :description
  validates :price, presence: true, numericality: { greater_than: 0 }

  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :item_orders
  has_many :orders, through: :item_orders

  has_attached_file :image, :default_url => ':placeholder'
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


  scope :available, -> { where(status: true) }
  scope :retired, -> { where(status: false) }

  def order_status
    if status == true
      "available"
    else
      "unavailable"
    end
  end

  def retired
    status == false
  end

  def available
    status == true
  end

  def modify_status(status_param)
    if status_param == "false"
      status = false
    else
      status = true
    end
  end

  def self.new_item_plus_categories(params)
    if params[:categories]
      params[:categories].delete("0")
      params[:categories] = params[:categories].map do |category_id|
        Category.find(category_id.to_i)
      end
    end
    item = self.new(params)
    item
  end

  def update_item_plus_categories(params)
    if params[:categories]
      params[:categories].delete("0")
      params[:categories] = params[:categories].map do |category_id|
        Category.find(category_id.to_i)
      end
    end
    self.update(params)
  end

end
