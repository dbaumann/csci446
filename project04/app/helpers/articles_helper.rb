module ArticlesHelper
  
  def wrap_in_paragraphs(text)
    "<p>" + text.gsub("\n\n", "</p>\n\n<p>") + "</p>"
  end
  
  def wrap_links(text)
    # credit for regex: http://stackoverflow.com/questions/2297490/ruby-url-regex-matcher
    text.gsub(/(?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?\/[^\s]*)?/ix) do |match|
      "<a href=\"#{match}\" target=\"_none\">#{match}</a>"
    end
  end
  
end
