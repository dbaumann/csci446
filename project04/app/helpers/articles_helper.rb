module ArticlesHelper
  
  def wrap_in_paragraphs(text)
    "<p>" + text.gsub("\n\n", "</p>\n\n<p>") + "</p>"
  end
  
end
