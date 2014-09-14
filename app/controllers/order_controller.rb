class OrderController < ApplicationController
  def index
    @orders = Order.closed? params[:history]==true
  end
  
  def new
    @o = Order.new
  end
  
  def create
    @o = Order.new order_params
    @o.created_by = claim.user
    
    if @o.valid?
      @o.save
      redirect_to order_path(@o)
    else
      render :template => 'order/new'
    end
  end
  
  def show
    @o = Order.includes('order_products').includes('products').find(params[:id])
  end
  
  def update
    o = Order.find(params[:id])
    
    case params[:operation]
    when 'update'
      if params[:status].present?
        Order.transaction do
          o.set_status_flags(params[:status])
          o.save!
          OrderHistory.create!(user: claim.user, order: o, action: 'update_status',
            data: { new_flag: o.status_flags }, message: params[:comment])
        end
      else
        OrderHistory.create!(user: claim.user, order: o, action: 'comment',
          message: params[:comment]) if params[:comment].present?
      end
    end
    return redirect_to order_path(o)
  end
  
  def destory
  end
  
  def product
    item = OrderProduct.new(:product => Product.using.find(params[:id]))
    form_prefix = "#{params[:form_prefix]}[#{params[:id]}]"
    render :partial => 'order/product_editor', :locals => {item: item, form_prefix: form_prefix}
  end
  
  private
  def order_params
    params.require(:order).permit(:summary, order_products_attributes: [:product_id, :quantity])
  end
end
