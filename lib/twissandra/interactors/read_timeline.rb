module Twissandra
  class ReadTimeline
    def self.perform(me)

      # * find Tweets from my Timeline
      timeline_entries = Timeline.find_all_by_user(me)

      # * load the Tweet details
      tweets = Tweet.find(timeline_entries.map(&:tweet_id))

      binding.pry

      # * load the User details
      users = User.find_all(tweets.map(&:user_id))

      tweets_with_users = tweets.zip(users).map do |tweet, user|
        {tweet: tweet, user: user}
      end

      # return an array of tweets with their relevant user
      {tweets: tweets_with_users}
    end
  end
end
