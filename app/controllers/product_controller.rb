class ProductController < ApplicationController
  def index
    @products = Product.all
  end
  
  def new
    @p = Product.new
  end
  
  def create
    @p = Product.new product_params
    if @p.save
      redirect_to product_path(@p)
    else
      render :template => 'product/new'
    end
  end
  
  def show
    @p = Product.unscoped.find(params[:id])
  end
  
  def edit
    @p = Product.find(params[:id])
  end
  
  def update
    @p = Product.find(params[:id])
    if @p.update_attributes product_params
      redirect_to product_path(@p)
    else
      render :template => 'product/edit'
    end
  end
  
  def destory
    @p = Product.find(params[:id])
    if @p.never_use?
      @p.destory
    else
      @p.update_attribute(:archived, true)
    end
  end
  
  private
  def product_params
    params.require(:product).permit(:manufacturer, :model_id, :color, :price, :width, :depth, :height)
  end
end
