namespace :feed do
  desc "Launch task to fetch feeds"
  task :fetch => :environment do
    fetcher = FeedFetcherJob.new
    fetcher.perform
  end
end