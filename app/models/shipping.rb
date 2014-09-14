class Shipping < ActiveRecord::Base
  include BitFlags
  bit_flags :status_flags, {
    0 => :received
  }
  
  belongs_to :order
  belongs_to :created_by, :class => User
  has_many :shipping_products
  has_many :products, :through => :shipping_products
  
  accepts_nested_attributes_for :shipping_products
  
  default_scope { order(:created_at) }
  
  
end
