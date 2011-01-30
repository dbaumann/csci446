#declare an xml order_list tag with a for_product attribute
xml.order_list :for_product => @product.title do #NOT AN ITERATION BLOCK
  for o in @orders
    #declare an xml order tag
    xml.order do #NOT AN ITERATION BLOCK
      #declare name and email xml tags
      #in ruby they're method invocations, but that's not immediately obvious, so use parens.
      xml.name(o.name)
      xml.email(o.email)
    end
  end
end
