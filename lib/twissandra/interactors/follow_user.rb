module Twissandra
  class FollowUser
    def self.perform(me, user)

      # * add User to my Friends
      Friend.add_user(me, user)

      # * add Me to the User's Followers
      Follower.add_user(user, me)

      # * add User's Tweets to my Timeline
      Userline.find_tweets(user).each do |userline_entry|
        tweet = Tweet.find(userline_entry.tweet_id)
        Timeline.add_tweet(me, tweet)
      end

      # return the user we followed
      {user: user}
    end
  end
end

