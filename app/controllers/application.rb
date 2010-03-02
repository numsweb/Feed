# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #set session keep time
  #require 'aasm'

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '572702701fc72a51f983f5d8586221a1'
  
  #def login_required
  #  unless session[:user_id]
      #redirect_to '/login'
  #  end
  #end
  
end
