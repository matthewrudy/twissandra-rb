module Twissandra
  class SendTweet
    def self.perform(me, tweet_hash)

      # * create a Tweet for Me
      tweet = Tweet.create_for_user(me, tweet_hash)
      Userline.add_tweet(me, tweet)

      # * add Tweet to my Followers Timelines
      Follower.find_all_by_user(me).each do |follower_entry|
        follower = User.find(follower_entry.follower_id)
        Timeline.add_tweet(follower, tweet)
      end

      # * add Tweet to *mentioned* users' Timeline
      # User.find_mentioned(tweet).each do |mentioned|
      #   Timeline.add_tweet(mentioned, tweet)
      # end

      {tweet: tweet}
    end
  end
end
