module Twissandra

  class Friend

    # CREATE TABLE friends (
    #   user_uuid   uuid,
    #   friend_uuid uuid,
    #   timestamp   timestamp,
    #
    #   PRIMARY KEY (user_uuid, friend_uuid)
    # );

    include Cequel::Record

    self.table_name = :friends

    key    :user_uuid,   :uuid
    key    :friend_uuid, :uuid
    column :timestamp,   :timestamp
  end
end
