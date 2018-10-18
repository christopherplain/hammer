module ApplicationHelper
  def flash_class(name)
    case name
      when "success" then "alert alert-success"
      when "alert" then "alert alert-danger"
      when "error" then "alert alert-warning"
      when "notice" then "alert alert-info"
    end
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def visibility
    (current_user.admin?) ? "visible" : "invisible"
  end
end
