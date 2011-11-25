class FeedsController < ApplicationController
  
  def index
    unless params[:type] && params[:type] == "read" #speed up the read display.
      #feed_urls = ["http://austin.craigslist.org/cpg/index.rss", "http://austin.craigslist.org/eng/index.rss", "http://austin.craigslist.org/sof/index.rss", "http://austin.craigslist.org/sad/index.rss", "http://austin.craigslist.org/web/index.rss", "https://www.elance.com/php/search/main/resultsproject.php?matchType=project&rss=1&matchKeywords=rails&catFilter=10183&statusFilter=10037&sortBy=timelistedSort&sortOrder=1", "http://www.guru.com/pro/ProjectResults.aspx?CID=102&BID=0&LOC=2"]
      @feeds = Feedzirra::Feed.fetch_and_parse(FEED_URLS)
      
      @feeds.each do |feed_url,listing|
      
        listing.entries.each do |entry|
          feed=Feed.find_by_feed_url(entry.url)
          if feed.blank?
            feed=Feed.create(:title => entry.title, :feed_url => entry.url,
                          :published => entry.published,
                          :summary => entry.summary.sanitize)
          end
        end
      end
    end
      if params[:type]
        if params[:type]=="all"
          @feeds = Feed.all
          session[:type]="all"
        elsif params[:type] == "read"
          @feeds = Feed.read
          session[:type]="read"
        end
      else
        @feeds = Feed.unread
        session[:type]="unread"
      end
    session[:search_item]=nil
    @read_count = Feed.read.count.to_s
    @unread_count = Feed.unread.count.to_s
  end
  
  def show
    @feed=Feed.find(params[:id])
    @feed.is_read=true
    @feed.save
    if session[:type]=="unread"
      @feeds = Feed.unread
    elsif session[:type]=="read"
      @feeds = Feed.read
    else
      @feeds=Feed.find(:all)
    end
    unless session[:search_item].blank?
      @feeds = Feed.search(session[:search_item])
    end
    @read_count = Feed.read.count.to_s
    @unread_count = Feed.unread.count.to_s
  end
  
  def search
    unless params[:search][:item].blank?
       session[:search_item]=params[:search][:item]
       @feeds = Feed.search(params[:search][:item])
       @unread_count = Feed.unread.count.to_s
       render :index and return
    else
      flash[:error] = "Please enter something to search for!"
      redirect_to feeds_path and return
    end
  end
    
end
