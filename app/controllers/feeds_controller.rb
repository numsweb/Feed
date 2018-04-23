class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  layout 'application'

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

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    if FEED_COLLECTION_AGENT == "delayed_job"
      fetcher = FeedFetcherJob.new
      fetcher.delay.perform
      Rails.logger.info "********************************************************\ndelayed job launched!\n********************************************************"
      flash[:notice] = "Feed::delayed_job fetching process launched"
    elsif FEED_COLLECTION_AGENT == "sidekiq"
      FetchWorker.perform_async
      Rails.logger.info "********************************************************\nsidekiq  launched!\n********************************************************"
      flash[:notice] = "Feed::sidekiq fetching process launched"
    else
      flash[:error] = "invalid FEED_COLLECTION_AGENT! Fetch aborted"
    end


    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_feed
    unless params[:search]
      @feed = Feed.find(params[:id])
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:title, :published, :summary, :created_at, :is_read, :updated_at)
    end
end
