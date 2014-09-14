module ApplicationHelper
  def layout_title(title, record=nil, &block)
    if record.present?
      concat "<h3>#{html_escape title}##{record.id}".html_safe
    else
      concat "<h3>#{html_escape title}".html_safe
    end
    
    yield if block_given?
    concat "</h3>".html_safe
  end
  
  def shared_form_attr()
    {class: 'form-horizontal', role: 'form'}
  end
end
