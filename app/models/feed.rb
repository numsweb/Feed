class Feed < ActiveRecord::Base
  has_many :mailings, :dependent => :destroy
  
   def find_email(text)
      @@logger.info "filtering email: "+text.inspect
      email_reg = /<a href=\"mailto:.*\">(.*)<\/a>/
      unless text.blank?
        email = text.scan(/<a href=\"mailto:.*\">(.*)<\/a>/)
        #puts email
        CGI.unescapeHTML(email.to_s)
      end
    end
    

end
