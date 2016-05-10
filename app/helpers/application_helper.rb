module ApplicationHelper
  def title_with_icon(title, icon)
    content_tag :div, class: 'row wrapper border-bottom white-bg page-heading' do
      content_tag :div, class: 'col-lg-8' do
        content_tag :h1 do
          content_tag(:i, '', class: "fa fa-#{icon}") + ' ' +
          title
        end
      end
    end
  end

  def link_with_icon(link, icon, text='', css_class='btn-xs', options={})
    content_tag :a, '', {href: link, class: "btn #{css_class}"}.merge!(options) do
      content_tag(:i, '', class: "fa fa-#{icon}")
      .concat content_tag(:span, " #{text}") if text
    end
  end

  def alert_class_for(flash_type)
    {
      success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end
end
