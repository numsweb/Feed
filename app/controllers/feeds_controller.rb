class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    unless params[:type] && params[:type] == "read" #speed up the read display.
      #feed_urls = ["http://austin.craigslist.org/cpg/index.rss", "http://austin.craigslist.org/eng/index.rss", "http://austin.craigslist.org/sof/index.rss", "http://austin.craigslist.org/sad/index.rss", "http://austin.craigslist.org/web/index.rss", "https://www.elance.com/php/search/main/resultsproject.php?matchType=project&rss=1&matchKeywords=rails&catFilter=10183&statusFilter=10037&sortBy=timelistedSort&sortOrder=1", "http://www.guru.com/pro/ProjectResults.aspx?CID=102&BID=0&LOC=2"]
      Rails.logger.info "Fetching feeds ..."

      FEED_URLS.each do |url|
        begin
          Timeout::timeout(30) do
            feed = Feedjira::Feed.fetch_and_parse(url,{ :max_redirects => 3 })
            feed.entries.each do |entry|
              feed=Feed.find_by_feed_url(entry.url)
              if feed.blank?
                begin
                  feed=Feed.create(:title => entry.title, :feed_url => entry.url,
                                   :published => entry.published,
                                   :summary => entry.summary.sanitize)
                rescue
                end
              end
            end
          end
        rescue Timeout::Error
          Rails.logger.info "fetch timed out for #{url}"
        rescue
        end
      end
    end

    if params[:type]
      if params[:type]=="all"
        @feeds = Feed.all_items
        session[:type]="all"
      elsif params[:type] == "read"
        @feeds = Feed.read
        session[:type]="read"
      else
        @feeds = Feed.unread
        session[:type]="unread"
      end
    else
      @feeds = Feed.all_items
      session[:type]="all"
    end
    session[:search_item]=nil
    @read_count = Feed.read.count.to_s
    @unread_count = Feed.unread.count.to_s
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    set_feed
    @feed.is_read=true
    @feed.save
    if session[:type]=="unread"
      @feeds = Feed.unread
    elsif session[:type]=="read"
      @feeds = Feed.read
    else
      @feeds=Feed.all
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

=begin
    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:title, :published, :summary, :created_at, :is_read, :updated_at)
    end
=end
end
