module ApplicationHelper
  include Pagy::Frontend

  class CustomMarkdownRenderer < Redcarpet::Render::HTML
    def paragraph(text)
      "<p class='my-custom-class'>#{text}</p>"
    end
  end

  def markdown_to_html(markdown_content)
    renderer = CustomMarkdownRenderer.new(hard_wrap: true, filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      tables: true,
      strikethrough: true,
    })
    markdown.render(markdown_content).html_safe
  end
end
