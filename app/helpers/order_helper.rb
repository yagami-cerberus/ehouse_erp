module OrderHelper
  def format_status_flags(flags)
    render :partial => 'order/status_flags', :locals => {:f => flags}
  end
end
