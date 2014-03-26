module Twissandra
  class ReadTimeline
    def self.perform(me, max_timestamp)

      # * find Tweets from my Timeline
      timeline_entries = Timeline.find_tweets(me, max_timestamp, limit: 200)

      # * load the Tweet details
      tweets = Tweet.find_for_timeline_entries(timeline_entries)

      # * load the User details
      users = User.find_for_tweets(tweets)

      tweets_with_users = tweets.zip(users).map do |tweet, user|
        {tweet: tweet, user: user}
      end

      # return an array of tweets with their relevant user
      {tweets: tweets_with_users}
    end
  end
end
