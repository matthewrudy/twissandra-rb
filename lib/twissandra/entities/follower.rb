module Twissandra

  class Follower

    # CREATE TABLE followers (
    #   user_uuid   uuid,
    #   follower_uuid uuid,
    #   timestamp   timestamp,

    #   PRIMARY KEY (user_uuid, follower_uuid)
    # );

    include Cequel::Record

    self.table_name = :followers

    key    :user_uuid,     :uuid
    key    :follower_uuid, :uuid
    column :timestamp,     :timestamp

    def self.add_user(user, follower)
      create(user_uuid: user.uuid, follower_uuid: follower_uuid, timestamp: Time.now)
    end
  end
end
