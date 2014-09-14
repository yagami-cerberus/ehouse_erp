class ShippingController < ApplicationController
  def new
    @s = Shipping.new :order => Order.find(params[:order_id])
    params[:last_shipping] = true
    
    init_product_ids = init_product_ids_params[:p]
    init_product_ids.each do |id|
      product = Product.find_by_id(id)
      if product
        p = @s.shipping_products.build
        p.product = product
      end
    end if init_product_ids
  end
  
  def create
    o = Order.find(params[:order_id])
    @s = Shipping.new shipping_params
    @s.created_by = claim.user
    @s.order = o
    
    if @s.valid?
      o.shipping = true
      o.ordering = false if params[:last_shipping]
      o.finished = o.canceled = false
      Order.transaction do
        @s.save!
        @s.order.save!
        OrderHistory.create!(user: claim.user, order: o, action: 'shipping',
          data: { shipping_id: @s.id }, message: params[:comment])
      end
      redirect_to order_path(o)
    else
      render :template => 'shipping/new'
    end
  end
  
  def update
    o = Order.find(params[:order_id])
    s = o.shippings.find(params[:id])
    
    case params[:operation]
    when 'received'
      s.received = true
      Order.transaction do
        s.save!
        # TODO: comment message?
        OrderHistory.create!(user: claim.user, order: o, action: 'shipping_received',
          data: { shipping_id: s.id }, message: params[:comment])
      end
    end
    redirect_to order_path(o)
  end
  
  private
  def init_product_ids_params
    params.permit({:p => []})
  end
  
  def shipping_params
    params.require(:shipping).permit(shipping_products_attributes: [:product_id, :quantity])
  end
end
