module Twissandra

  class Timeline

    # CREATE TABLE timeline (
    #   user_id       uuid,
    #   tweet_id      timeuuid,
    #   tweet_user_id uuid,
    #
    #   PRIMARY KEY (user_id, tweet_id)
    # )
    #
    # WITH CLUSTERING ORDER BY (tweet_id DESC);

    include Cequel::Record

    self.table_name = :timeline

    key    :user_id,       :uuid
    key    :tweet_id,      :timeuuid
    column :tweet_user_id, :uuid

    def self.add_tweet(user, tweet)
      create(user_id: user.id, tweet_id: tweet.id, tweet_user_id: tweet.user_id)
    end
  end
end
