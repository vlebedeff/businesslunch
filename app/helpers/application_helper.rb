module ApplicationHelper
  def navbar_link_to(title, path, icon = '', prefix = true)
    content_tag :li, class: ('active' if current_page?(path)) do
      link_to(iconized_text(title, icon, prefix).html_safe, path)
    end
  end

  def iconized_text(text, icon, prefix = true)
    prefix ? "#{glyphicon(icon)} #{text}" : "#{text} #{glyphicon(icon)}"
  end

  def glyphicon(name)
    if name
      content_tag :i, '', class: "glyphicon glyphicon-#{name}"
    else
      ''
    end
  end
end
