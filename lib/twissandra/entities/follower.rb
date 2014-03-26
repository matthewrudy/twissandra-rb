module Twissandra

  class Follower

    # CREATE TABLE followers (
    #   user_id     uuid,
    #   follower_id uuid,
    #   timestamp   timestamp,

    #   PRIMARY KEY (user_id, follower_id)
    # );

    include Cequel::Record

    self.table_name = :followers

    key    :user_id,     :uuid
    key    :follower_id, :uuid
    column :timestamp,     :timestamp

    def self.add_user(user, follower)
      create(user_id: user.id, follower_id: follower.id, timestamp: Time.now)
    end

    def self.find_all_by_user(user)
      self[user.id]
    end
  end
end
