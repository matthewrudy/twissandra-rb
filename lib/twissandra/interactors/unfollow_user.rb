module Twissandra
  class UnfollowUser
    def perform(me, user)

      # * remove User from my Friends
      Friend.remove_user(me, user)

      # * remove Me from User's Followers
      Follower.remove_user(user, me)

      # * remove User's Tweets from my Timeline
      Timeline.remove_tweets_from_user(me, user)

      # return the user we unfollowed
      {user: user}
    end
  end
end
