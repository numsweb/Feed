class FeedFetcherJob

  def perform
    FEED_URLS.each do |url|
      begin
        Timeout::timeout(30) do
          feed = Feedjira::Feed.fetch_and_parse(url[0],{ :max_redirects => 3 })
          feed.entries.each do |entry|
            feed=Feed.find_by_feed_url(entry.url)
            if feed.blank?
              begin
                feed=Feed.create(:title => url[1] + "::" + entry.title, :feed_url => entry.url,
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
    end #FEED_URLS
  end #perform
end #class