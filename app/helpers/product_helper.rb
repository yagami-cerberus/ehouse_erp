module ProductHelper
  def formated_color(product)
    if product.color.present?
      product.color
    else
      "N/A"
    end
  end
  
  def formated_price(product)
    if product.price.present?
      "¥ #{product.price}"
    else
      "N/A"
    end
  end
  
  def formated_size(product)
    if product.width.present? &&
       product.depth.present? &&
       product.height.present?
      size = product.width * product.depth * product.height
      "#{size} cm³ (W: #{product.width} /D: #{product.depth} /H: #{product.height} cm)"
    else
      "N/A (W: #{product.width} /D: #{product.depth} /H: #{product.height} cm)"
    end
  end
end
