# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  
  def nav_li(link_text, path, confirm)
    if confirm == ""
      "<li class='#{path == request.path ? "sel_link" : "unsel_link"}'>#{link_to(link_text, path)}</li>"
    else
      "<li class='#{path == request.path ? "sel_link" : "unsel_link"}'>#{link_to(link_text, path, confirm)}</li>"
    end
  end
  
  
end
