class FeedFetcherJob

  def perform
    Rails.logger.info "***** Performing FeedFetcherJob *****"
    FEED_URLS.each do |url|
      begin
        Timeout::timeout(30) do
          #feed = Feedjira::Feed.fetch_and_parse(url[1],{ :max_redirects => 3 })
          feed = Feedjira::Feed.fetch_and_parse(url[1])
          feed.entries.each do |entry|
            feed=Feed.find_by_feed_url(entry.url)
            if feed.blank?
              begin
                feed=Feed.create(:title => url[0] + " - " + entry.title, :feed_url => entry.url,
                                 :published => entry.published,
                                 :summary => entry.summary.sanitize)
              rescue
                rails.logger.info "***** Error processing entry: #{entry.inspect} *****"
              end
            end
          end
        end
      rescue Timeout::Error
        Rails.logger.info "fetch timed out for #{url}"
      rescue
      end
    end #FEED_URLS
    Rails.logger.info "***** Finished FeedFetcherJob *****"
  end #perform

end
