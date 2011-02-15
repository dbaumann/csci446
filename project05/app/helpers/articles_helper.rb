module ArticlesHelper
  
  def wrap_links(text)
    #this regex adapted from http://regexlib.com/REDetails.aspx?regexp_id=90
    valid_url = /(?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?[\/a-z0-9\-\.\?\=\_]*)?/ix
    
    text.gsub(valid_url) do |match|
      "<a href=\"#{match}\" target=\"_none\">#{match}</a>"
    end
  end
  
end
