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

  def self.new_plus_categories(params)
    if params[:categories]
      params[:categories].delete("0")
      params[:categories] = params[:categories].map do |category_id|
        Category.find(category_id.to_i)
      end
    end
    item = self.new(params)
    item
  end

  def update_plus_categories(params)
    if params[:categories]
      params[:categories].delete("0")
      params[:categories] = params[:categories].map do |category_id|
        Category.find(category_id.to_i)
      end
    end
    self.update(params)
  end

end
