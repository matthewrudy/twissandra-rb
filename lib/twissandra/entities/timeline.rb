module Twissandra

  class Timeline

    # CREATE TABLE timeline (
    #   user_uuid       uuid,
    #   tweet_uuid      timeuuid,
    #   tweet_user_uuid uuid,
    #
    #   PRIMARY KEY (user_uuid, tweet_uuid)
    # )
    #
    # WITH CLUSTERING ORDER BY (tweet_uuid DESC);

    include Cequel::Record

    self.table_name = :timeline

    key    :user_uuid,       :uuid
    key    :tweet_uuid,      :timeuuid
    column :tweet_user_uuid, :uuid
  end
end
