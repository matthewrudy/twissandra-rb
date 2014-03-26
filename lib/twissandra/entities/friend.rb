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

    def self.add_user(user, friend)
      create(user_uuid: user.uuid, friend_uuid: friend.uuid, timestamp: Time.now)
    end
  end
end
