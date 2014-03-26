module Twissandra

  class Userline

    # CREATE TABLE userline (
    #   user_id  uuid,
    #   tweet_id timeuuid,
    #
    #   PRIMARY KEY (user_id, tweet_id)
    # )
    #
    # WITH CLUSTERING ORDER BY (tweet_id DESC);

    include Cequel::Record

    self.table_name = :userline

    key :user_id,  :uuid
    key :tweet_id, :timeuuid

    def self.add_tweet(user, tweet)
      create(user_id: user.id, tweet_id: tweet.id)
    end
  end
end
