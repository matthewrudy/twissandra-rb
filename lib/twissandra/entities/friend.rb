module Twissandra

  class Friend

    # CREATE TABLE friends (
    #   user_id   uuid,
    #   friend_id uuid,
    #   timestamp timestamp,
    #
    #   PRIMARY KEY (user_id, friend_id)
    # );

    include Cequel::Record

    self.table_name = :friends

    key    :user_id,   :uuid
    key    :friend_id, :uuid
    column :timestamp,   :timestamp

    def self.add_user(user, friend)
      create(user_id: user.id, friend_id: friend.id, timestamp: Time.now)
    end
  end
end
