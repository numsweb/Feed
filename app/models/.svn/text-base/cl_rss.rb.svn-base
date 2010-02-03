require 'rexml/document'
require 'uri'
require 'net/http'
require 'cgi'
class CLRss
    attr_accessor :results
    attr_accessor :rejected
    
    @@logger = ActiveRecord::Base.logger
    
    CITIES = %w{http://albany.craigslist.org/ http://allentown.craigslist.org/ 
      http://albuquerque.craigslist.org/ http://anchorage.craigslist.org/ http://annarbor.craigslist.org/ http://asheville.craigslist.org/ 
      http://atlanta.craigslist.org/ http://bakersfield.craigslist.org/ http://austin.craigslist.org/ http://bakersfield.craigslist.org/ 
      http://baltimore.craigslist.org/ http://batonrouge.craigslist.org/ http://bham.craigslist.org/ http://boise.craigslist.org/ 
      http://boston.craigslist.org/ http://buffalo.craigslist.org/ http://burlington.craigslist.org/ http://chambana.craigslist.org/ 
      http://charleston.craigslist.org/ http://charlotte.craigslist.org/ http://chicago.craigslist.org/ http://chico.craigslist.org/ 
      http://cincinnati.craigslist.org/ http://cleveland.craigslist.org/ http://columbia.craigslist.org/ http://columbus.craigslist.org/ 
      http://dallas.craigslist.org/ http://delaware.craigslist.org/ http://dayton.craigslist.org/ http://denver.craigslist.org/ 
      http://desmoines.craigslist.org/ http://detroit.craigslist.org/ http://elpaso.craigslist.org/ http://eugene.craigslist.org/ 
      http://fortmyers.craigslist.org/ http://fresno.craigslist.org/ http://grandrapids.craigslist.org/ http://greensboro.craigslist.org/
       http://harrisburg.craigslist.org/ http://hartford.craigslist.org/ http://houston.craigslist.org/ http://honolulu.craigslist.org/
        http://humboldt.craigslist.org/ http://indianapolis.craigslist.org/ http://inlandempire.craigslist.org/ http://ithaca.craigslist.org/ 
        http://jackson.craigslist.org/ http://jacksonville.craigslist.org/ http://kansascity.craigslist.org/ http://knoxville.craigslist.org/ 
        http://littlerock.craigslist.org/ http://lexington.craigslist.org/ http://losangeles.craigslist.org/ http://louisville.craigslist.org/ 
        http://maine.craigslist.org/ http://madison.craigslist.org/ http://memphis.craigslist.org/ http://miami.craigslist.org/ http://milwaukee.craigslist.org/ 
        http://minneapolis.craigslist.org/ http://mobile.craigslist.org/ http://modesto.craigslist.org/ http://montana.craigslist.org/ http://monterey.craigslist.org/
         http://montgomery.craigslist.org/ http://nashville.craigslist.org/ http://nh.craigslist.org/ http://newhaven.craigslist.org/ http://newjersey.craigslist.org/ 
         http://newyork.craigslist.org/ http://neworleans.craigslist.org/ http://norfolk.craigslist.org/ http://nd.craigslist.org/ http://oklahomacity.craigslist.org/ 
         http://omaha.craigslist.org/ http://orangecounty.craigslist.org/ http://orlando.craigslist.org/ http://pensacola.craigslist.org/ http://philadelphia.craigslist.org/ 
         http://phoenix.craigslist.org/ http://pittsburgh.craigslist.org/ http://portland.craigslist.org/ http://puertorico.craigslist.org/ http://providence.craigslist.org/
          http://raleigh.craigslist.org/ http://redding.craigslist.org/ http://reno.craigslist.org/ http://richmond.craigslist.org/ http://rochester.craigslist.org/ 
          http://sacramento.craigslist.org/ http://saltlakecity.craigslist.org/ http://sanantonio.craigslist.org/ http://sandiego.craigslist.org/ http://www.craigslist.org/ 
          http://slo.craigslist.org/ http://santabarbara.craigslist.org/ http://savannah.craigslist.org/ http://seattle.craigslist.org/ http://shreveport.craigslist.org/
           http://sd.craigslist.org/ http://spokane.craigslist.org/ http://stlouis.craigslist.org/ http://stockton.craigslist.org/ http://syracuse.craigslist.org/ 
           http://tallahassee.craigslist.org/ http://tampa.craigslist.org/ http://toledo.craigslist.org/ http://tucson.craigslist.org/ http://tulsa.craigslist.org/ 
           http://washingtondc.craigslist.org/ http://westernmass.craigslist.org/ http://westpalmbeach.craigslist.org/ http://wv.craigslist.org/ http://wichita.craigslist.org/ 
           http://wyoming.craigslist.org/ http://calgary.craigslist.org/ http://edmonton.craigslist.org/ http://halifax.craigslist.org/ http://montreal.craigslist.org/ 
           http://ottawa.craigslist.org/ http://quebec.craigslist.org/ http://saskatoon.craigslist.org/ http://toronto.craigslist.org/ http://vancouver.craigslist.org/ 
           http://victoria.craigslist.org/ http://winnipeg.craigslist.org/ http://amsterdam.craigslist.org/ http://athens.craigslist.org/ http://barcelona.craigslist.org/ 
           http://berlin.craigslist.org/ http://brussels.craigslist.org/ http://budapest.craigslist.org/ http://copenhagen.craigslist.org/ http://florence.craigslist.org/
            http://frankfurt.craigslist.org/ http://geneva.craigslist.org/ http://hamburg.craigslist.org/ http://helsinki.craigslist.org/ http://lyon.craigslist.org/ 
            http://madrid.craigslist.org/ http://marseilles.craigslist.org/ http://milan.craigslist.org/ http://moscow.craigslist.org/ http://munich.craigslist.org/ 
            http://naples.craigslist.org/ http://oslo.craigslist.org/ http://paris.craigslist.org/ http://prague.craigslist.org/ http://rome.craigslist.org/ 
            http://stpetersburg.craigslist.org/ http://stockholm.craigslist.org/ http://vienna.craigslist.org/ http://warsaw.craigslist.org/ http://zurich.craigslist.org/ 
            http://belfast.craigslist.org/ http://birmingham.craigslist.org/ http://bristol.craigslist.org/ http://cardiff.craigslist.org/ http://dublin.craigslist.org/
             http://edinburgh.craigslist.org/ http://glasgow.craigslist.org/ http://leeds.craigslist.org/ http://liverpool.craigslist.org/ http://london.craigslist.org/
              http://manchester.craigslist.org/ http://newcastle.craigslist.org/}.freeze
    # CITIES = %w{http://austin.craigslist.org/}.freeze
    BAD_VERBAGE = ["in house", "ebay", 'e-bay', "join our team", "on site", "on-site", "full time", "full-time", "instructors", "asp","cold fusion", "tutor", "manager",
      ".net"].freeze  
    # BAD_VERBAGE = []
	BAD_EMAILS = ['google.com','clearcreekit.com','kearneyco.com','HR@rhfleet.org'].freeze
	
	def initialize
      self.results = {}
      self.rejected = []
      
      cycle_cities
	end
	
	def cycle_cities
	   CITIES.each do |city|
	     self.results[city] = parse(city+"web/index.rss", city)
	   end
	end
	
	def parse(url,city)
	  @@logger.info "Getting content for #{url}"
		content = Net::HTTP.get_response(URI.parse(url))

    @@logger.info "Starting XML Parse"
		xml = REXML::Document.new(content.body)
		data = {}
		data['items'] = []

    
		xml.elements.each('//item') do |item|
			it = {}
			it['title'] = item.elements['title'].text
			it['link'] = item.elements['link'].text
			if filter(it)
        data['items'] << it 
        @@logger.info "approved ad #{it["link"]}"
        save_success(it)
      else 
        if it['save']
          @@logger.info "rejected ad #{it["link"]}"
          self.rejected << it 
          save_rejected(it) 
        end
      end
		end
		data
	# rescue 
	# 	raise "Timed out trying to access #{URI.parse(url).inspect} Content: #{content.inspect}"
	# 	raise "Error in getting/parsing #{URI.parse(url).inspect}"        
	end
	
	def filter(item)
	   #check the link and see if we have this link already
	  # if EmailQueue.find(:first, :conditions => "link = '#{item['link']}'")
	  #   item['reject_reason'] = 'link found in database'
	  #   item['save'] = false;
	  #   return false
	  # end
	   
	   #check the ad subject for verbage
        if filter_verbage(item['title'], item, BAD_VERBAGE) 
           item['reject_reason'] = "bad verbage in subject"
            return false 
        end
	   
   	   item['link'].gsub!('art/','web/')
	   @@logger.info "link: #{item['link']}"
	   #fetch the ad text
	   item['ad_text'] = fetch(item['link'])
	   
	   @@logger.info "ad text: #{item['ad_text']}"
	   #get the email
	   item['email'] = find_email(item['ad_text'])
	   	   
	   #check the ad text for verbage
	   if filter_verbage(item['ad_text'], item,  BAD_VERBAGE)
	     item['reject_reason'] = "bad verbage in message"
	     return false 
	   end
	   
       #check the email against the database 
      # if !item['email'].empty?
           
    	 #  if EmailQueue.find(:first, :conditions => "email = '#{item['email']}' ")
    	#     item['reject_reason'] = 'email address or link found in database'
    	#     return false 
    	#   end
  	  # end
	   
	   #check the link against the db
	   #if EmailQueue.find(:first, :conditions => "link = '#{item['link']}'")
	  #   return false
    # end
     
	   #if it's all good, return true.	   
	   return true
	end
	
	def fetch(url)
      res = Net::HTTP.get_response(URI.parse(url.to_s))    
      @@logger.info "text body: #{res.body}"
      if res.body =~ /<h2>/
      	if $' =~ /<br>\n<hr>\n<br>\n/
      	   return "<h2>#{$`}"
      	end
      end	   
	end
    
    def filter_verbage(text, item , verbage)
      verbage.each {|verb|
        @@logger.info "filtering verbage: "+text.inspect
        if text.downcase.match(%r{verb.downcase})
          item['verbage_found'] = verb.to_s
          return true
        end
      }
      return false
    end
    
    def find_email(text)
      @@logger.info "filtering email: "+text.inspect
      email_reg = /<a href=\"mailto:.*\">(.*)<\/a>/
      email = text.scan(/<a href=\"mailto:.*\">(.*)<\/a>/)
#      puts email
      CGI.unescapeHTML(email.to_s) 
    end


    def save_success(item)
     # EmailQueue.create(
    #    :ad_text => item['ad_text'],
    #    :email => item['email'],
    #    :title => item['title'],
    #    :link => item['link'],
    #    :sent_at => 'NULL'
    #  )
    end
    
    def save_rejected(item)
      #EmailQueue.create(
      #  :ad_text => item['ad_text'] || '',
      #  :email => item['email'] || '',
      #  :title => item['title'],
      #  :link => item['link'],
      #  :rejected => 1,
      #  :sent_at => 'NULL'     
      #)
#      puts "\n saving rejected #{item['link']}\n"
    end
	
end
