#choose the asynch job handler.
# delayed_job uses database to store job info
# sidekiq used redis data store
#
# if using sidekiq, start redis with:   redis-server --port 6379 --daemonize yes
#
# clear sidekiq queue (from rails console): Sidekiq.redis { |conn| conn.flushdb }
# or ()from command line):  redis-cli flushdb

#FEED_COLLECTION_AGENT = "delayed_job"
FEED_COLLECTION_AGENT = "sidekiq"