class Item < ActiveRecord::Base
  validates_presence_of :title, :description, :price

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
