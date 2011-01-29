module StoreHelper
  
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none" #add to the existing set of attributes
    end
    
    #return this
    content_tag("div", attributes, &block)
    #wraps the output created by &block with a div tag with attributes attributes
  end
  
end
