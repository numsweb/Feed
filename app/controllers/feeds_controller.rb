class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    if params[:type] && params[:type]=="all"
      @feeds = Feed.all_items
      session[:type]="all"
    elsif params[:type] && params[:type] == "read"
      @feeds = Feed.read
      session[:type]="read"
    else
      @feeds = Feed.unread
      session[:type]="unread"
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
      @feeds=Feed.all_items
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

  def delayed_fetch
    #use delayed job to fetch new feeds, but they will not be available until next page load....
    Rails.logger.info "********************************************************\nLaunching job to fetch feeds ...\n********************************************************"
    fetcher = FeedFetcherJob.new
    fetcher.delay.perform
    Rails.logger.info "********************************************************\ndelayed job launched!\n********************************************************"
    flash[:notice] = "Feeds fetching process launched"
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      unless params[:search]
        @feed = Feed.find(params[:id])
      end
    end

  def feed_params
    params.require(:feed).permit(:title, :published, :summary, :created_at, :is_read, :updated_at)
  end

=begin
    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:title, :published, :summary, :created_at, :is_read, :updated_at)
    end
=end
end
