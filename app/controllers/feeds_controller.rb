class FeedsController < ApplicationController
  
  require 'rss/2.0'
  require 'open-uri'
  
  
  # GET /feeds
  # GET /feeds.xml
  def index
    @feeds = Feed.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feeds }
    end
  end

  # GET /feeds/1
  # GET /feeds/1.xml
  def show
    @feed = Feed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feed }
    end
  end

  # GET /feeds/new
  # GET /feeds/new.xml
  def new
    @feed = Feed.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feed }
    end
  end

  # GET /feeds/1/edit
  def edit
    @feed = Feed.find(params[:id])
  end

  # POST /feeds
  # POST /feeds.xml
  def create
    @feed = Feed.new(params[:feed])

    respond_to do |format|
      if @feed.save
        flash[:notice] = 'Feed was successfully created.'
        format.html { redirect_to(@feed) }
        format.xml  { render :xml => @feed, :status => :created, :location => @feed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.xml
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        flash[:notice] = 'Feed was successfully updated.'
        format.html { redirect_to(@feed) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.xml
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to(feeds_url) }
      format.xml  { head :ok }
    end
  end
  
    # logic Fetch feed, store each item in the DB if its not there already
    # then in the show function fetch all items that are not marked as "read"
    
    # Allow the show function to submit and have check boxes to hide read items
    # Also have a page to show all (read in one color and unread in another) 
  def purge
     setting = Setting.find(:first)
      if setting.purge
          @feeds = Feed.find(:all)
          for feed in @feeds
            #puts feed.created_at.to_f.to_s + " less than  " + (setting.keep_time.to_i).days.ago.to_f.to_s + "?"
            #puts feed.created_at.to_f < (setting.keep_time.to_i).days.ago.to_f
            
            #if (feed.created_at.to_f < (setting.keep_time.to_i).days.ago.to_f) && (feed.is_read)
            # unfortunately created_at is the time we saved in the DB, not the time it was posted on CL
            # an improvement would be to look at the posting itself and get the posted time from the text
            # but save that for later....
            if (Time.now - setting.keep_time.to_i.day ) > feed.created_at
              feed.destroy
           end
         end
      end
    redirect_to show_all_feeds_path
  end
  
  def show_feeds
    setting=Setting.find :first
    session[:keep_time] = setting.keep_time
      #now get new ones
      get_new
  end
  
  def mark_feeds
    for param in params
      if param[0].match("feed_")
        feed = Feed.find(param[1].to_i)
        feed.is_read = 1
        feed.save
      end
    end
    redirect_to show_feeds_path
  end
  
  def show_all_feeds
    if session[:keep_time].nil?
  	  session[:keep_time]=Settings.find(:first).keep_time
  	end 
      @sof = Feed.find(:all, :conditions => ["heading=?", "Software QA DBA" ], :order => "created_at ASC")
      @web = Feed.find(:all, :conditions => ["heading=?", "Web Info Design" ], :order => "created_at ASC")
      @eng = Feed.find(:all, :conditions => ["heading=?", "Internet Engineers" ], :order => "created_at ASC")
     	@cpg = Feed.find(:all, :conditions => ["heading=?", "Computer Gigs" ], :order => "created_at ASC")
     	@sn = Feed.find(:all, :conditions => ["heading=?", "System Network" ], :order => "created_at ASC")
     	@postings = @sof.size + @web.size + @eng.size + @cpg.size + @sn.size
  end 
  
  def make_data(url, heading)
    	content = Net::HTTP.get_response(URI.parse(url))
   		xml = REXML::Document.new(content.body)
   		xml.elements.each('//item') do |item|
   			it = {}
   			it['heading'] = heading
   			it['title'] = item.elements['title'].text
   			it['link'] = item.elements['link'].text
           @fetch_data['items'] << it 
      end
   end
   
   def show_post
     @feed = Feed.find(params[:id])
     @feed.is_read = 1
     @feed.save
     @feed_body =fetch(@feed.link)
     @email = @feed.find_email(@feed_body)
   end
   
   def remote_show_post
      
    @feed = Feed.find(params[:id])
     @feed.is_read = 1
     @feed.save
     @feed_body =fetch(@feed.link)
            logger.info "\n\n********* body " + @feed_body + " ****\n\n"
     @email = @feed.find_email(@feed_body)
     if params[:called_from] == "show_feeds"
    	  get_new
  	  end
    	
   end
   
   def search
     @results = Feed.find(:all, :conditions => ["link LIKE ? or title LIKE ?" , "%#{params[:search][:item]}%","%#{params[:search][:item]}%" ])
   end
   
   def fetch(url)
       res = Net::HTTP.get_response(URI.parse(url.to_s))

       #if res.body =~ /<h2>/
       #	if $' =~ /<br>\n<hr>\n<br>\n/
       #	   return "<h2>#{$`}"
       #	end
       #else
         return res.body
       #end	   
    end
 	
    def get_new

      #switch to getting the data from the DB for the view
      
      #process the feeds
      @fetch_data = {}
     	@fetch_data['items'] = []
     	
      url = "http://austin.craigslist.org/web/index.rss"
     	make_data(url,'Web Info Design')
     	
     	url = "http://austin.craigslist.org/eng/index.rss"
     	make_data(url,'Internet Engineers')
     	
     	url = "http://austin.craigslist.org/sof/index.rss"
     	make_data(url,'Software QA DBA')
     	
     	url = "http://austin.craigslist.org/cpg/index.rss"
     	make_data(url,'Computer Gigs')
     	
     	    	url = "http://austin.craigslist.org/sad/index.rss"
     	make_data(url,'System Network')
     	
     	#@data holds all the feed info now
     	
     	#how about this, Fetch all, then do a search in the resulting array to see if its in the DB
     	sql = "select link from feeds"
      @feeds = Feed.find_by_sql(sql)
     	
     	@fetch_data['items'].each do |feed|
        #test = @feeds.detect{|item| /"#{feed}"/ =~item }
     	  test = Feed.find(:first, :conditions => "link = '" + feed['link'] + "'")
     	  if test.nil?
     	     newfeed = Feed.new({:link => feed['link'], :heading => feed['heading'], :title => feed['title']})
     	     newfeed.save
     	  end
     	 end
     	
     	#now fetch the stored items for display
      @sof = Feed.find(:all, :conditions => ["is_read = ? AND heading=?", 0,"Software QA DBA" ], :order => "created_at DESC")
      @web = Feed.find(:all, :conditions => ["is_read = ? AND heading=?", 0,"Web Info Design" ], :order => "created_at DESC")
      @eng = Feed.find(:all, :conditions => ["is_read = ? AND heading=?", 0,"Internet Engineers" ], :order => "created_at DESC")
      @cpg = Feed.find(:all, :conditions => ["is_read = ? AND heading=?", 0,"Computer Gigs" ], :order => "created_at DESC")
      @sn = Feed.find(:all, :conditions => ["is_read = ? AND heading=?", 0,"System Network" ], :order => "created_at DESC")
     	@postings = @sof.size + @web.size + @eng.size + @cpg.size

 	  
  end
  
end
