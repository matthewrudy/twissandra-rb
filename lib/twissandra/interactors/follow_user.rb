module Twissandra
  class FollowUser
    def self.perform(me, user)

      # * add User to my Friends
      Friend.add_user(me, user)

      # * add Me to the User's Followers
      Follower.add_user(user, me)

      # * add User's Tweets to my Timeline
      Userline.find_tweets(user) do |userline_entry|
        Timeline.add_tweet_from_userline(userline_entry, me)
      end

      # return the user we followed
      {user: user}
    end
  end
end

