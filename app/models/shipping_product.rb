class ShippingProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :shipping

  validates :quantity, numericality: { :only_integer => true, :greater_than_or_equal_to => 0}
  
end
