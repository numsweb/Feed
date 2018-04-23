class FetchWorker
  include Sidekiq::Worker


  def perform()
    fetcher = FeedFetcherJob.new
    fetcher.perform
  end
end
