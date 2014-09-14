class Product < ActiveRecord::Base
  has_many :order_products
  has_many :orders, :through => :order_products
  has_many :shipping_products
  has_many :shippings, :through => :shipping_products
  
  validate :manufacturer, presence: true, length: { maximum: 250 }
  validate :model_id, presence: true, length: { maximum: 250 }
  validate :color, length: { maximum: 100 }
  validate :price, numericality: { only_integer: true, allow_nil: true }
  validate :width, numericality: { only_integer: false, allow_nil: true }
  validate :depth, numericality: { only_integer: false, allow_nil: true }
  validate :height, numericality: { only_integer: false, allow_nil: true }
  
  scope :using, -> { where :archived => false }
  
  def never_use?
    orders.count == 0 && shippings.count == 0
  end
  
  def related_products
    @_related_products ||= Product.where('id!=? AND "manufacturer"=? AND "model_id"=?',
      self.id, self.manufacturer, self.model_id)
  end
end
