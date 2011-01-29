# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def current_time
    Time.now.strftime("%I:%M%p %Z")
  end
  
end
