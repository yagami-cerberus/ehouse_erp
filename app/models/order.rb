class Order < ActiveRecord::Base
  include BitFlags
  bit_flags :status_flags, {
    1 => :ordering,
    4 => :shipping,
    25 => :finished,
    26 => :canceled
  }
  
  belongs_to :created_by, :class => User
  
  has_many :shippings
  has_many :order_products
  has_many :order_histories
  has_many :products, :through => :order_products
  
  accepts_nested_attributes_for :order_products
  
  scope :closed?, -> (is_closed) {
    if is_closed
      status_flags_include :finished, :canceled
    else
      status_flags_exclude :finished, :canceled
    end
  }
  
  def set_status_flags(new_status)
    case new_status
    when 'padding'
      self.status_flags = 0
    when 'ordering'
      self.status_flags = 1 << 1
    when 'ordering_and_shipping'
      self.status_flags = (1 << 1) + (1 << 4)
    when 'shipping'
      self.status_flags = 1 << 4
    when 'finished'
      self.status_flags = 1 << 25
    when 'cancel'
      self.status_flags = 1 << 26
    else
      raise "Unknow Status: #{new_status}"
    end
  end
end
