class Layouts::Application < Mustache::Rails
  
  def render_stylesheets
    stylesheet_link_tag :all
  end
  
  def render_javascripts
    javascript_include_tag "jquery-1.4.2.min", "jquery.previewable_comment_form", "jquery.text_selection-1.0.0.min", "jquery.tabs", "gollum"
  end
  
  def link_to_root
    link_to "The Awesome Blog", root_path
  end

  def flash_messages
    content_tag(:p, flash[:notice], :class => "flash notice")
  end
end
