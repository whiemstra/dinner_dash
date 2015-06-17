class Item < ActiveRecord::Base
  validates :title, presence: true,
    uniqueness: true
  validates_presence_of :description, :price

  validates :price, numericality: { only_integer: true, greater_than: 0 }

  has_many :item_categories
  has_many :categories, through: :item_categories

  has_attached_file :image, :default_url => ':placeholder'
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
