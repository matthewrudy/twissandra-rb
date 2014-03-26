module Twissandra

  class Tweet

    # CREATE TABLE tweets (
    #   uuid      timeuuid,
    #   user_uuid uuid,
    #   body      text,
    #   mentions  set<uuid>,

    #   PRIMARY KEY (uuid)
    # );

    include Cequel::Record

    self.table_name = :tweets

    key    :uuid,      :timeuuid, auto: true
    column :user_uuid, :uuid
    column :body,      :text

    # INSERT INTO tweets
    #   (uuid, user_uuid, body)
    # VALUES
    #   (?, ?, ?)
    # ;
    #

    def self.create_for_user(user, tweet_hash)
      tweet_attributes = tweet_hash.slice(:body).merge(user_uuid: user.uuid)

      create(tweet_attributes)
    end
  end
end
