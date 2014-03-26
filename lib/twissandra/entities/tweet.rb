module Twissandra

  class Tweet

    # CREATE TABLE tweets (
    #   id       timeuuid,
    #   user_id  uuid,
    #   body     text,
    #   mentions set<uuid>,

    #   PRIMARY KEY (id)
    # );

    include Cequel::Record

    self.table_name = :tweets

    key    :id,      :timeuuid, auto: true
    column :user_id, :uuid
    column :body,    :text

    # INSERT INTO tweets
    #   (id, user_id, body)
    # VALUES
    #   (?, ?, ?)
    # ;
    #

    def self.create_for_user(user, tweet_hash)
      tweet_attributes = tweet_hash.slice(:body).merge(user_id: user.id)

      create(tweet_attributes)
    end
  end
end
