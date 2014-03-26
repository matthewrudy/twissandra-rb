module Twissandra

  class Userline

    # CREATE TABLE userline (
    #   user_uuid uuid,
    #   tweet_uuid timeuuid,
    #
    #   PRIMARY KEY (user_uuid, tweet_uuid)
    # )
    #
    # WITH CLUSTERING ORDER BY (tweet_uuid DESC);

    include Cequel::Record

    self.table_name = :userline

    key :user_uuid,  :uuid
    key :tweet_uuid, :timeuuid

    def self.add_tweet(user, tweet)
      create(user_uuid: user.uuid, tweet_uuid: tweet.uuid)
    end
  end
end
